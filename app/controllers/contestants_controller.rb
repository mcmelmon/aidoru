class ContestantsController < ApplicationController
    before_action :correct_group, only: [:add_to_group, :make_center, :remove_from_group]

    def add_to_group
        @contestant.add_to_group(@group)
        redirect_to root_path
    end

    def make_center
        @contestant.make_center(@group)
        redirect_to params[:back] == 'index' ? root_path : group_path(@group)
    end

    def remove_from_group
        @contestant.remove_from_group(@group)
        redirect_to params[:back] == 'index' ? root_path : group_path(@group)
    end

    def show
        @contestant = Contestant.find_by(id: params[:id])
        if @contestant.blank?
            redirect_to root_path
            return
        end
    end

    private

        def correct_group
            @group = current_user.current_group
            redirect_to root_path if @group.blank?
            @contestant = Contestant.find_by(id: params[:id])
        end
end
