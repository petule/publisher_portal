class AddCurrencyTo < ActiveRecord::Migration[8.0]
  def change
    add_reference :languages, :currency, index: true
  end
end
