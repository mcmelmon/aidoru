module ApplicationHelper
    def youtube_video(url)
        id = url.gsub(/https:\/\/youtu.be\//,'')
        embed = "https://www.youtube.com/embed/#{id}"
        render :partial => 'layouts/video', :locals => { :url => embed }
    end
end
