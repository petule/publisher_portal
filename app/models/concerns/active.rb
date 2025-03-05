module Active
  extend ActiveSupport::Concern

  included do
    scope :by_active,->  { where(active: true) }

    def available_to_order?
      active
    end
  end
end
