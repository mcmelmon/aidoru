class CreateRankings < ActiveRecord::Migration[5.2]
  def change
    create_table :contest_rankings do |t|
      t.belongs_to :contestant
      t.integer :period
      t.integer :rank

      t.timestamps
    end
  end
end
