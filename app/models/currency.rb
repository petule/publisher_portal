class Currency < ApplicationRecord
  scope :by_code, -> (code) { where(code: code) }
end
