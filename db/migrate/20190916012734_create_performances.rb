class CreatePerformances < ActiveRecord::Migration[5.2]
  def change
    create_table :performances do |t|
      t.belongs_to :contestant, foreign_key: true
      t.string :youtube_video_id
      t.string :name_native
      t.string :name_english

      t.timestamps
    end
  end
end
