class CreateSeries < ActiveRecord::Migration[8.0]
  def change
    create_table :series do |t|
      t.string :title
      t.string :subtitle
      t.text :short_content
      t.text :content
      t.string :video
      t.string :isbn_epub
      t.string :isbn_mobi
      t.string :isbn_pdf
      t.boolean :active

      t.timestamps
    end
  end
end
