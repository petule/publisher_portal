class CreateCategoryType < ActiveRecord::Migration[8.0]
  def change
    create_table :category_types do |t|
      t.string :name
      t.string :title
      t.string :code, index: true
      t.text :content
      t.boolean :active
      t.references :language, null: false, foreign_key: true
      t.string :seo_title
      t.string :seo_description

      t.timestamps
    end
  end
end
