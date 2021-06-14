class AddDogIdToToys < ActiveRecord::Migration[6.1]
  def change
    add_column :toys, :dog_id, :int, null:false
    add_column :toys, :color, :string, null:false
  end
end
