class CreateContestantAddsAndContestantRemoves < ActiveRecord::Migration[5.2]
  def change
    create_table :group_adds do |t|
      t.belongs_to :contestant
      t.belongs_to :group

      t.timestamps
    end

    create_table :group_removes do |t|
      t.belongs_to :contestant
      t.belongs_to :group

      t.timestamps
    end
  end
end
