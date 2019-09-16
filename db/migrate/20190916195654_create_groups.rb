class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.belongs_to :contest
      t.belongs_to :user
      t.string :name
      t.integer :center_id

      t.timestamps
    end
  end
end
