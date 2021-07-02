class CreateDogRentalRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :dog_rental_requests do |t|
      t.integer :dog_id, null:false
      t.date :start_date, null:false
      t.date :end_date, null:false
      t.string :status, null:false, default:"PENDING"
      t.timestamps
    end
    add_index:dog_rental_requests, :dog_id
  end
end
