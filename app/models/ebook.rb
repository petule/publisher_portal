class Ebook < ApplicationRecord
  belongs_to :series
  belongs_to :language
  belongs_to :publisher
  has_many :ebook_authors
  has_many :authors, through: :ebook_authors

  has_one_attached :main_image
  has_many_attached :images
  has_one_attached :file_pdf
  has_one_attached :file_mobi
  has_one_attached :file_epub

  has_one_attached :file_pdf_pattern
  has_one_attached :file_mobi_pattern
  has_one_attached :file_epub_pattern
end
