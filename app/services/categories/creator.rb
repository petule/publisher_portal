module Categories
  class Creator
    prepend SimpleCommand

    attr_reader :create_params
    def initialize(create_params)
      @create_params = create_params
    end

    def call
      category = Category.new(create_params)
      unless category.save
        copy_errors(category, :category)
      end
      category
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
