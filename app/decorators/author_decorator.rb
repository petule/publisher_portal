class AuthorDecorator < ApplicationDecorator
  include ActionView::Helpers::TextHelper
  PER_PAGES_DEFAULT = 10.freeze
  PER_PAGES = [ 2, 10, 20, 30 ].freeze
  delegate_all
  decorates_association :ebooks
  decorates_association :visible_ebooks

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
    decorate_collection(Author.all).map { |a| [a.full_name_and_type, a.id] }
  end

  def full_name
    if degree.present?
      "#{degree} #{first_name} #{last_name}"
    else
      "#{first_name} #{last_name}"
    end
  end

  def full_name_and_type
    "#{full_name} (#{I18n.t("dials.author_type.#{author_type}")})"
  end

  def content_trim
    truncate(content, length: 20)
  end
end
