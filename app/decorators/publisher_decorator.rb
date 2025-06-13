class PublisherDecorator < Draper::Decorator
  include ActionView::Helpers::TextHelper
  delegate_all
  PER_PAGES_DEFAULT = 10.freeze
  PER_PAGES = [ 2, 10, 20, 30 ].freeze

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
  def content_trim
    truncate(content, length: 20)
  end

  def address_trim
    truncate(address, length: 20)
  end

  def self.select_options
    decorate_collection(Publisher.all).map { |p| [p.title, p.id] }
  end
end
