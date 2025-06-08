module Categories
  class Mover
    prepend SimpleCommand

    attr_reader :category, :position, :parent_id
    def initialize(id, position, parent_id = null)
      @category = Category.find(id)
      @position = position.to_i
      @parent_id = parent_id
    end

    def call
      #category.insert_at(position)
      category.category_id = parent_id
      category.save

      category
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.record.errors.full_messages.join(', '))
      nil
    rescue StandardError => e
      errors.add(:base, I18n.t('views.admin.categories.move_error') + e.message)
    end
  end
end
