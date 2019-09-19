class AddContestToContestants < ActiveRecord::Migration[5.2]
  def change
    add_column :contestants, :contest_id, :integer
  end
end
