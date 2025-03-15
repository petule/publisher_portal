class AddEmailToPublisher < ActiveRecord::Migration[8.0]
  def change
    add_column :publishers, :email, :string
  end
end
