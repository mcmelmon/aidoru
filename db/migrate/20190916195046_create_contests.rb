class CreateContests < ActiveRecord::Migration[5.2]
  def change
    create_table :contests do |t|
      t.string :name_native
      t.string :name_english
      t.string :url
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
