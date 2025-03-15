module ApplicationHelper
  def active_if(controller, action = nil)
    active?(controller, action) ? 'active' : 'inactive'
  end

  def active?(controller, actions = nil)
    actions = Array.wrap(actions)
    if actions.present?
      params[:controller] == controller && actions.include?(params[:action])
    else
      params[:controller] == controller
    end
  end

  def environment
    return 'production' if Rails.env.production?
    return 'test' if Rails.env.test?

    'dev'
  end

  def user_policy
    @user_policy ||= UserPolicy.new(current_user)
  end
end
