class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  #include Pundit::Authorization
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :detect_turbo

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:alert] = I18n.t("#{policy_name}.#{exception.query}", default: t('views.user_not_authorized'))
    redirect_to root_path
  end

  def detect_turbo
    @turbo_request = request.headers["Turbo-Frame"].present? || request.headers["Turbo-Visit"].present?
  end
end
