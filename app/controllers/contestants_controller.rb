class ContestantsController < ApplicationController
    before_action :correct_group, only: [:add_to_group, :make_center, :remove_from_group]

    def add_to_group
        @group.group_members.create!(contestant: @contestant)
        redirect_to root_path
    end

    def make_center
        @group.update_attribute(:center_id, @contestant.id)
        redirect_to root_path
    end

    def remove_from_group
        @group.group_members.find_by(contestant: @contestant).destroy
        redirect_to root_path
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
