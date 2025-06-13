class AddOnDeleteNullifyToCategoryCategoryId < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :categories, column: :category_id
    add_foreign_key :categories, :categories, column: :category_id, on_delete: :nullify

    change_column_null :categories, :category_id, true
  end
end
