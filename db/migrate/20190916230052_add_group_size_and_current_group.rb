class AddGroupSizeAndCurrentGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :contests, :group_size, :integer
    add_column :users, :current_group_id, :integer
  end
end
