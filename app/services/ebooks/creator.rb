module Ebooks
  class Creator
    prepend SimpleCommand

    attr_reader :create_params
    def initialize(create_params)
      @create_params = create_params
    end

    def call
      ebook = Ebook.new(create_params)
      unless ebook.save
        copy_errors(ebook, :ebook)
      end
      ebook
    rescue StandardError => e
      puts "e.message: #{e.message}"
      errors.add(:base, e.message)
    end

    private

    def copy_errors(model, key)
      model.errors.full_messages.each { |msg| errors.add(key, msg) }
    end
  end
end
