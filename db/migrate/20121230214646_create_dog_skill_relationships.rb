class CreateDogSkillRelationships < ActiveRecord::Migration
  def change
    create_table :dog_skill_relationships do |t|
      t.integer :dog_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
