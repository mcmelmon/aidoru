class HomeController < ApplicationController
    def about
        @message = ContactMessage.new
    end

    def index
        # TODO: this is lol, but it's accurate; figure out the join/merge magic
        ranked_contestant_ids = Contestant.all.map {|c| [c.id, c.current_rank] }.sort{|a,b| a[1] <=> b[1]}.map{|c| c[0]}
        current_group_ids = current_user.present? && current_user.current_group.present? ? current_user.current_group.contestants.pluck(:id) : []
        @contestant_ids = ranked_contestant_ids - current_group_ids
        render :homepage
    end
end