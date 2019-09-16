class HomeController < ApplicationController
    def index
        @contestants = Contestant.all.order('id')
        render :homepage
    end
end