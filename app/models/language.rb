class Language < ApplicationRecord
  include Active
  has_many :categories
end
