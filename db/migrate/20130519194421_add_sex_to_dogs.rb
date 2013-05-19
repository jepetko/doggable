class AddSexToDogs < ActiveRecord::Migration
  def change
    add_column :dogs, :sex, :string, :limit => 1
  end
end
