class HomeController < ApplicationController
    def index
        @contestants = current_user.current_group.blank? ? Contestant.all.order('id') : Contestant.where.not(id: current_user.current_group.contestants.all.map(&:id)).order('id')
        render :homepage
    end
end