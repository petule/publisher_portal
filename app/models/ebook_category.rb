class EbookCategory < ApplicationRecord
  belongs_to :ebook
  belongs_to :category
end
