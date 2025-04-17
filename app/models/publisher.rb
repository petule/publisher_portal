class Publisher < ApplicationRecord
  include Active
  has_rich_text :content

  has_many :ebooks, dependent: :nullify
  has_many :users, dependent: :nullify
  validates :url, uniqueness: true
  validates :title, presence: true
  validates :email, uniqueness: true, presence: true

  scope :ordered_by, ->(column, direction = 'asc') {
    allowed_columns = column_names.map(&:to_s) # Získá seznam povolených sloupců

    column = allowed_columns.include?(column.to_s) ? column.to_sym : 'id' # Ověření sloupce
    direction = %w[asc desc].include?(direction) ? direction : 'asc' # Ověření směru

    order(column => Arel.sql(direction)) # Použití Arel.sql() jen pro směrování
  }
  scope :search, ->(query) {
    where("LOWER(title) LIKE unaccent(:query) OR LOWER(url) LIKE unaccent(:query) OR LOWER(address) LIKE unaccent(:query) OR LOWER(email) LIKE unaccent(:query)", query: "%#{query.downcase}%")
  }
end
