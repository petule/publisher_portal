class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Pundit::Authorization
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :detect_turbo

  private

  def detect_turbo
    @turbo_request = request.headers["Turbo-Frame"].present? || request.headers["Turbo-Visit"].present?
  end
end
