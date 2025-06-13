class Author < ApplicationRecord
  has_many :ebook_authors
  has_many :ebooks, through: :ebook_authors
  enum :author_type, { author: 0, illustrator: 1, translator: 2 }, default: :author, suffix: false
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
    author_type_key = Authors::AuthorTypeMatcher.call(query).result
    author_type_value = author_types[author_type_key] if author_type_key
    where("LOWER(first_name) LIKE :query OR LOWER(last_name) LIKE :query OR LOWER(content) LIKE :query #{" OR author_type = :author_type "if author_type_value}",
          query: "%#{query.downcase}%", author_type: author_type_value)
  }
end
