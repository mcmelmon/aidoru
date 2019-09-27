class CreateGroupScores < ActiveRecord::Migration[5.2]
  def change
    create_table :group_scores do |t|
      t.belongs_to :group
      t.integer :period
      t.integer :score

      t.timestamps
    end
  end
end
