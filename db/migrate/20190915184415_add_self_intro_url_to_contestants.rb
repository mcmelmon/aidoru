class AddSelfIntroUrlToContestants < ActiveRecord::Migration[5.2]
  def change
    add_column :contestants, :self_introduction_video_url, :string
  end
end
