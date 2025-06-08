class EbookDecorator < Draper::Decorator
  include ActionView::Helpers::TextHelper
  PER_PAGES_DEFAULT = 10.freeze
  PER_PAGES = [ 2, 10, 20, 30 ].freeze
  decorates_association :authors
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def authors_list
    authors.map(&:full_name_and_type).join(', ')
  end

  def licence_end
    licence_end_at&.strftime("%d.%m %Y")
  end

  def updated
    updated_at&.strftime("%d.%m %Y")
  end
end
