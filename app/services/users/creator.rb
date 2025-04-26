module Users
  class Creator
    prepend SimpleCommand

    attr_reader :create_params
    def initialize(create_params)
      @create_params = create_params
    end

    def call
      generated_password = Devise.friendly_token.first(8)
      user = User.new(create_params.merge(password: generated_password, password_confirmation: generated_password))
      if user.save
        UserMailer.welcome_email(user, generated_password).deliver_later
      else
        copy_errors(user, :user)
      end
      user
    rescue StandardError => e
      errors.add(:base, e.message)
    end

    private

    def copy_errors(model, key)
      model.errors.full_messages.each { |msg| errors.add(key, msg) }
    end
  end
end
