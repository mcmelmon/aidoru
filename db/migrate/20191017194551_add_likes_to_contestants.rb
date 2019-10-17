class AddLikesToContestants < ActiveRecord::Migration[5.2]
  def change
    add_column :contestants, :likes, :integer
  end
end
