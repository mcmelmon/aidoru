class ContestantsController < ApplicationController
    def show
        @contestant = Contestant.find_by(id: params[:id])
        if @contestant.blank?
            redirect_to root_path
            return
        end
    end
end
