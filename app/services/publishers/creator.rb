module Publishers
  class Creator
    prepend SimpleCommand

    attr_reader :create_params, :admin_params
    def initialize(create_params, admin_params)
      @create_params = create_params
      @admin_params = admin_params
    end

    def call
      publisher = nil

      ActiveRecord::Base.transaction do
        publisher = Publisher.new(create_params)

        unless publisher.save
          publisher.errors.full_messages.each { |msg| errors.add(:publisher, msg) }
          raise ActiveRecord::Rollback
        end

        generated_password = Devise.friendly_token.first(8)
        user = User.new(
          publisher: publisher,
          email: admin_params[:email],
          first_name: admin_params[:first_name],
          last_name: admin_params[:last_name],
          password: generated_password,
          password_confirmation: generated_password
        )

        unless user.save
          user.errors.full_messages.each { |msg| errors.add(:user, msg) }
          raise ActiveRecord::Rollback
        end

        user.publisher_admin_role!
        UserMailer.welcome_email(user, generated_password).deliver_later
      end

      publisher
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.record.errors.full_messages.join(', '))
      nil





    #publisher = Publisher.create!(create_params)
    #  generated_password = Devise.friendly_token.first(8)
    #  user = User.create!(publisher: publisher, email: publisher.email, first_name: admin_params[:first_name],
    #               last_name: admin_params[:last_name], password: generated_password,
    #               password_confirmation: generated_password)
    #  user.publisher_admin_role!
    #  UserMailer.welcome_email(user, generated_password).deliver_later
    end
  end
end
