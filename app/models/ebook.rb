class Ebook < ApplicationRecord
  belongs_to :series, optional: true
  belongs_to :language
  belongs_to :publisher
  has_many :ebook_authors, dependent: :destroy
  has_many :authors, through: :ebook_authors

  has_many :ebook_categories, dependent: :destroy
  has_many :categories, through: :ebook_categories

  validates :isbn, uniqueness: true
  validates :isbn_epub, uniqueness: true, if: -> { file_epub.present? }

  has_one_attached :main_image
  has_many_attached :images
  has_one_attached :file_pdf
  has_one_attached :file_mobi
  has_one_attached :file_epub

  has_one_attached :file_pdf_pattern
  has_one_attached :file_mobi_pattern
  has_one_attached :file_epub_pattern

  enum :state, { iniciated: 0, checked: 1, imported: 2 }, default: :user, suffix: true

  scope :ordered_by, ->(column, direction = 'asc') {
    allowed_columns = column_names.map(&:to_s)

    column = allowed_columns.include?(column.to_s) ? column.to_sym : 'id'
    direction = %w[asc desc].include?(direction) ? direction : 'asc'

    order(column => Arel.sql(direction)).distinct
  }
  scope :search, ->(query) {
    left_joins(:authors)
      .where("LOWER(ebooks.id::text) LIKE unaccent(:query) OR LOWER(title) LIKE unaccent(:query) OR LOWER(subtitle) LIKE unaccent(:query) OR unaccent(LOWER(authors.first_name)) LIKE unaccent(:query) OR unaccent(LOWER(authors.last_name)) LIKE unaccent(:query)", query: "%#{query.downcase}%")
  }

  def main_image_full
    main_image.variant(resize_to_fill: [48, 48]).processed
  end
  def main_image_thumb
    main_image.variant(resize_to_fill: [24, 24]).processed
  end
end
