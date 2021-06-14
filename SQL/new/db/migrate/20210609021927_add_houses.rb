class AddHouses < ActiveRecord::Migration[6.1]
  def change
    create_table :houses do |t|
      t.string :name, null:false
      t.timestamps
    end
    
  end
end
