class AddUserIdToDogs < ActiveRecord::Migration
  def change
    add_column :dogs, :user_id, :integer
  end
end
