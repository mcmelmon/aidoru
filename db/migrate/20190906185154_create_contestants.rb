class CreateContestants < ActiveRecord::Migration[5.2]
  def change
    create_table :contestants do |t|

      t.string :name_english
      t.string :name_native
      t.string :headshot_url
      t.string :bodyshot_url
      t.string :profile_url

      t.timestamps
    end
  end
end
