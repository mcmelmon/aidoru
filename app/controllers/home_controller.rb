class HomeController < ApplicationController
    def index
        @contestants = if current_user.present?
            current_user.current_group.blank? ? Contestant.all.order('id') : Contestant.where.not(id: current_user.current_group.contestants.all.map(&:id)).order('id')
        else
            Contestant.all.order('id')
        end
        render :homepage
    end
end