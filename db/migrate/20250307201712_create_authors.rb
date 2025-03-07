class CreateAuthors < ActiveRecord::Migration[8.0]
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.string :degree
      t.text :content
      t.boolean :active, default: true
      t.text :product_content

      t.timestamps
    end
  end
end
