class Series < ApplicationRecord
  has_many :ebooks, dependent: :nullify
  validates :isbn, uniqueness: true, presence: true
  scope :ordered_by, ->(column, direction = 'asc') {
    allowed_columns = column_names.map(&:to_s)

    column = allowed_columns.include?(column.to_s) ? column.to_sym : 'id'
    direction = %w[asc desc].include?(direction) ? direction : 'asc'

    order(column => Arel.sql(direction))
  }
  scope :search, ->(query) {
    where("LOWER(title) LIKE unaccent(:query) OR LOWER(subtitle) LIKE unaccent(:query) OR LOWER(isbn) LIKE unaccent(:query)", query: "%#{query.downcase}%")
  }
end
