module ApplicationHelper
    def youtube_video(video_id)
        embed = "https://www.youtube.com/embed/#{video_id}"
        render :partial => 'layouts/video', :locals => { :url => embed }
    end
end
