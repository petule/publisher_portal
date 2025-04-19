class UserDecorator < Draper::Decorator
  include ActionView::Helpers::TextHelper
  delegate_all
  PER_PAGES_DEFAULT = 10.freeze
  PER_PAGES = [ 2, 10, 20, 30 ].freeze

  def self.collection_decorator_class
    PaginatingDecorator
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def role
    user.role.present? ? I18n.t("dials.role.#{user.role}") : ''
  end
end
