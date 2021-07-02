class CreatePolls < ActiveRecord::Migration[6.1]
  def change
    create_table :polls do |t|
      t.integer :author_id, null:false
      t.string :title, null:false
      t.timestamps
    end
    add_index :polls, :author_id
    add_index :polls, :title
    add_index :users, :name
  end
end
