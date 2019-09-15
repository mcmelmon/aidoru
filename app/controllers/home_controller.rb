class HomeController < ApplicationController
    def index
        @contestants = Contestant.all
        render :homepage
    end
end