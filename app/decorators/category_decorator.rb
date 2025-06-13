class CategoryDecorator < ApplicationDecorator
  include ActionView::Helpers::TextHelper
  PER_PAGES_DEFAULT = 10.freeze
  PER_PAGES = [ 2, 10, 20, 30 ].freeze
  delegate_all
  decorates_association :language

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def self.select_options
    decorate_collection(Category.all).map { |c| ["#{c.name} (#{c.language&.name})", c.id] }
  end

  def content_trim
    truncate(content, length: 20)
  end
end
