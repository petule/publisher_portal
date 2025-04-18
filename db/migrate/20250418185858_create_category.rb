class CreateCategory < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :title
      t.string :url, index: true
      t.text :content
      t.text :parent_categories
      t.boolean :active, index: true
      t.string :seo_title
      t.string :seo_description
      t.boolean :favourite, default: false, index: true
      t.references :language, null: false, foreign_key: true
      t.references :category_type, null: false, foreign_key: true, index: true
      t.references :category, null: true, foreign_key: true, index: true

      t.timestamps
    end
  end
end
