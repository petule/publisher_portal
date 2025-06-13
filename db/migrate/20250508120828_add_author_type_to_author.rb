class AddAuthorTypeToAuthor < ActiveRecord::Migration[8.0]
  def change
    add_column :authors, :author_type, :integer, default: 0
  end
end
