class CreateMostLikedContestants < ActiveRecord::Migration[5.2]
  def change
    create_table :most_liked_contestants do |t|
      t.belongs_to :contest
      t.belongs_to :contestant

      t.timestamps
    end
  end
end
