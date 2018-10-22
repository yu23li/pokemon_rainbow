class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|
      t.string :name, :limit => 45, :null => false
      t.integer :power, :null => false
      t.integer :max_pp
      t.string :element_type, :limit => 45

      t.timestamps
    end
  end
end
