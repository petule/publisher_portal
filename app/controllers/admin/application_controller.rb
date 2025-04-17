module Admin
  class ApplicationController < ::ApplicationController
    include Pundit
    before_action :authenticate_admin!

    private

    def authenticate_admin!
      authorize :current_user, :admin_access?
    rescue Pundit::NotAuthorizedError
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
