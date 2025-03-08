class CreateExchangeRates < ActiveRecord::Migration[8.0]
  def change
    create_table :exchange_rates do |t|
      t.references :currency, null: false, foreign_key: true
      t.decimal :ex_rate
      t.integer :quantity
      t.date :valid_from
      t.date :valid_to
      t.boolean :active

      t.timestamps
    end
  end
end
