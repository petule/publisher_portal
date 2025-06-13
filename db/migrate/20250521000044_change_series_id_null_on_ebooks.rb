class ChangeSeriesIdNullOnEbooks < ActiveRecord::Migration[8.0]
  def change
    change_column_null :ebooks, :series_id, true
  end
end
