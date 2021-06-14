class AddHouseIdToDogs < ActiveRecord::Migration[6.1]
  def change
    add_column :dogs, :house_id, :int, null:false
  end
end
