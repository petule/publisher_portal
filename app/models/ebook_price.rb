class EbookPrice < ApplicationRecord
  belongs_to :currency
  belongs_to :ebook
end
