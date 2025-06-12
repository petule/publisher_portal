module Categories
  class Mover
    prepend SimpleCommand

    attr_reader :category, :new_position
    def initialize(id, new_position)
      @category = Category.find(id)
      @new_position = new_position.to_i + 1
    end

    def call
      move_to_position
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.record.errors.full_messages.join(', '))
      nil
    rescue StandardError => e
      puts "#{e.message}: #{e.backtrace}"
      errors.add(:base, I18n.t('views.admin.categories.move_error') + e.message)
    end

    private

    def move_to_position
      normalize_positions
      category.reload
      return if new_position == category.position

      Category.transaction do
        if new_position < category.position
           category.siblings.where(position: new_position...category.position)
                  .update_all("position = position + 1")
        else
          category.siblings.where(position: (category.position + 1)..new_position)
                  .update_all("position = position - 1")
         end

        category.update!(position: new_position)
      end
    end

    def normalize_positions
      count = category.siblings.count
      expected_sum = (count * (count + 1)) / 2
      actual_sum   = siblings.sum(:position)
      return if expected_sum == actual_sum
      expected = 1
      category.siblings.each do |cat|
        if cat.position != expected
          cat.update_column(:position, expected)
        end
        expected += 1
      end
    end
  end
end
