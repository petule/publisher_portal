class ExchangeRate < ApplicationRecord
  include Active

  belongs_to :currency
end
