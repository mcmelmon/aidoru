module ApplicationHelper
    def open_graph_description
        @group.present? ? @group.description : page_description
    end

    def open_graph_title
        @group.present? ? @group.name : page_title
    end

    def open_graph_url
        request.url
    end

    def open_graph_image
        if @group.present?
            @group.center.headshot_url if @group.center.present?
        end
    end

    def page_description
        content_for(:page_description)
    end

    def page_title
        ['Oijofie', content_for(:title)].compact.join(' | ')
    end

    def youtube_video(video_id)
        embed = "https://www.youtube.com/embed/#{video_id}"
        render :partial => 'layouts/video', :locals => { :url => embed }
    end
end
