module Ebooks
  class Updator
    prepend SimpleCommand

    attr_reader :id, :update_params
    def initialize(id, update_params)
      @id = id
      @update_params = update_params
    end

    def call
      ebook = Ebook.find(id)
      unless ebook.update(update_params)
        copy_errors(ebook, :ebook)
        raise ActiveRecord::Rollback
      end

      ebook
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
