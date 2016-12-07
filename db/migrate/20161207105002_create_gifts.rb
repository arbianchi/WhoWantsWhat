class CreateGifts < ActiveRecord::Migration[5.0]
  def change
    create_table :gifts do |t|
      t.string :name
      t.integer :buyer_id,       null: true
      t.integer :requester_id
      t.integer :list_id
      t.integer :created_by

      t.timestamps
    end
  end
end
