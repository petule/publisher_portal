class Author < ApplicationRecord
  has_many :ebook_authors
  has_many :ebooks, through: :ebook_authors
  scope :ordered_by, ->(column, direction = 'asc') {
    direction = %w[asc desc].include?(direction) ? direction : 'asc'

    case column
    when 'full_name'
      order(Arel.sql("first_name || ' ' || last_name #{direction}"))
    when 'content', 'active'
      order(column => direction)
    else
      order(Arel.sql("first_name || ' ' || last_name #{direction}"))
    end
  }
  scope :search, ->(query) {
    where("LOWER(first_name) LIKE :query OR LOWER(last_name) LIKE :query OR LOWER(content) LIKE :query", query: "%#{query.downcase}%")
  }
end
