class EnableUnaccentExtension < ActiveRecord::Migration[8.0]
  def change
    execute "CREATE EXTENSION IF NOT EXISTS unaccent;"
  end
end
