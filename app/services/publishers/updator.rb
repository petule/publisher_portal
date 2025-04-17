module Publishers
  class Updator
    prepend SimpleCommand

    attr_reader :update_params, :id
    def initialize(id, update_params)
      @id = id
      @update_params = update_params
    end

    def call
      publisher = Publisher.find(id)
      unless publisher.update(update_params)
        copy_errors(publisher, :publisher)
        raise ActiveRecord::Rollback
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
