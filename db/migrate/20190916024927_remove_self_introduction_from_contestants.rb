class RemoveSelfIntroductionFromContestants < ActiveRecord::Migration[5.2]
  def change
    remove_column :contestants, :self_introduction_video_url
  end
end
