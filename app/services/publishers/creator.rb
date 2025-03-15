module Publishers
  class Creator
    prepend SimpleCommand

    attr_reader :create_params, :admin_params
    def initialize(create_params, admin_params)
      @create_params = create_params
      @admin_params = admin_params
    end

    def call
      publisher = Publisher.create!(create_params)
      generated_password = Devise.friendly_token.first(8)
      user = User.create!(publisher: publisher, email: publisher.email, first_name: admin_params[:first_name],
                   last_name: admin_params[:last_name], password: generated_password,
                   password_confirmation: generated_password)
      user.publisher_admin_role!
      UserMailer.welcome_email(user, generated_password).deliver_later
    end
  end
end
