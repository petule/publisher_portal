class RenameAnnotationInEbook < ActiveRecord::Migration[8.0]
  def change
    rename_column :ebooks, :anotation, :annotation
  end
end
