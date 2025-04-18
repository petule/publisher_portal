class CategoryType < ApplicationRecord
  EBOOKS = 'e-books'.freeze
  AUDIO_BOOKS = 'audio-books'.freeze

  has_many :categories
  belongs_to :language

  validates :code, uniqueness: { scope: :language_id }
  scope :by_code_and_locale, ->(code, locale) { where(code: code).where(language: Language.find_by(code: locale))}
  scope :ebooks, ->(locale) { by_code_and_locale(EBOOKS, locale).first }
  scope :audio_books, ->(locale) { by_code_and_locale(AUDIO_BOOKS, locale).first }
end
