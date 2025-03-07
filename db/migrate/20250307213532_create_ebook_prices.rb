class CreateEbookPrices < ActiveRecord::Migration[8.0]
  def change
    create_table :ebook_prices do |t|
      t.decimal :base_price, precision: 10, scale: 2
      t.decimal :price, precision: 10, scale: 2
      t.references :currency, null: false, foreign_key: true
      t.references :ebook, null: false, foreign_key: true
      t.date :valid_from
      t.date :valid_to
      t.boolean :active

      t.timestamps
    end
  end
end
