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
          copy_errors(publisher, :publisher)
          raise ActiveRecord::Rollback
        end

        generated_password = Devise.friendly_token.first(8)
        user = User.new(
          publisher: publisher,
          email: create_params[:email],
          first_name: admin_params[:first_name],
          last_name: admin_params[:last_name],
          password: generated_password,
          password_confirmation: generated_password
        )

        unless user.save
          copy_errors(user, :user)
          raise ActiveRecord::Rollback
        end

        user.publisher_admin_role!
        UserMailer.welcome_email(user, generated_password).deliver_later
      end

      publisher
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.record.errors.full_messages.join(', '))
      nil
    rescue StandardError => e
      errors.add(:base, e.message)
    end

    private

    def copy_errors(model, key)
      model.errors.full_messages.each { |msg| errors.add(key, msg) }
    end
  end
end
