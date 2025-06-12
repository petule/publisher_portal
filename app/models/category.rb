class Category < ApplicationRecord
  include Active
  default_scope { order(:position) }
  FAVOURITE_COUNT = 12.freeze

  belongs_to :language
  belongs_to :category_type
  belongs_to :parent_category, class_name: 'Category', foreign_key: :category_id, optional: true
  has_many :categories
  has_many :active_categories, -> { by_active }, class_name: 'Category'
  has_many :ebook_categories
  has_many :ebooks, through: :ebook_categories

  scope :by_favourite, -> { where(favourite: true) }
  scope :by_ebook, ->(locale) { where(category_type: CategoryType.ebooks(locale)) }
  scope :by_audio_book, ->(locale) { where(category_type: CategoryType.audio_books(locale)) }
  scope :by_first_category, -> { where(category_id: nil).order(:position) }
  scope :by_url, ->(url) { where(url: url) }
  validates :url, uniqueness: { scope: [:language_id, :category_type_id] }

  after_save :recalculate_parent_categories, if: :saved_change_to_category_id?

  serialize :parent_categories, coder: YAML, type: Array

  acts_as_tree order: :position

  def self.by_ebook_url(url, locale)
    by_active.by_ebook(locale).by_url(url).first
  end

  def ebook?
    category_type.code.to_s == CategoryType::EBOOKS
  end

  def siblings
    Category.where(category_id: category_id).where(language_id: language_id).order(:position)
  end

  def audio_book?
    category_type.code.to_s == CategoryType::AUDIO_BOOKS
  end

  def ebook_subcategories(locale)
    ids = [self.id]
    categories.by_active.by_ebook(locale).each do |child_category|
      ids << child_category.id
      child_category.categories.by_active.by_ebook(locale).each do |child_category_2|
        ids << child_category_2.id
        child_category.categories.by_active.by_ebook(locale).each do |child_category_3|
          ids << child_category_3.id
          child_category.categories.by_active.by_ebook(locale).each do |child_category_4|
            ids << child_category_4.id
          end
        end
      end
    end

    ids
  end

  private

  def recalculate_parent_categories
    cat = []
    category = self
    while category.parent_category.present?
      cat << category.category_id
      category = category.parent_category
    end

    update_column(:parent_categories, cat)
  end
end
