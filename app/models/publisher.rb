class Publisher < ApplicationRecord
  include Active

  has_many :users, dependent: :nullify
  validates :url, uniqueness: true
end
