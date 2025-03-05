class CreatePublisher < ActiveRecord::Migration[8.0]
  def change
    create_table :publishers do |t|
      t.string :title
      t.text :content
      t.string :address
      t.string :url
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
