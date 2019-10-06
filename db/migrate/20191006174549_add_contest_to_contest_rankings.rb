class AddContestToContestRankings < ActiveRecord::Migration[5.2]
  def change
    add_column :contest_rankings, :contest_id, :integer
  end
end
