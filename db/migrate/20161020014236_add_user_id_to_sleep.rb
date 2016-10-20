class AddUserIdToSleep < ActiveRecord::Migration[5.0]
  def change
    add_column :sleeps, :user_id, :integer
  end
end
