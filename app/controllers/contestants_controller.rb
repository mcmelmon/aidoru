class ContestantsController < ApplicationController
    before_action :correct_group, only: [:add_to_group, :make_center, :remove_from_group]

    def add_to_group
        @contestant.add_to_group(@group)
        redirect_to root_path
    end

    def groups
        @contestant = Contestant.find_by(id: params[:id])
        @groups = Group.includes_contestant(params[:id]).page(params[:page]).order('updated_at DESC')
    end

    def like
        @contestant = Contestant.find_by(id: params[:id])
        likes = @contestant.likes.present? ? @contestant.likes + 1 : 1
        @contestant.update_attribute(:likes, likes)
    end

    def make_center
        @contestant.make_center(@group)
        redirect_to edit_group_path(@group)
    end

    def remove_from_group
        @contestant.remove_from_group(@group)
        redirect_to edit_group_path(@group)
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
            @group = current_user.groups.find_by(id: params[:group_id])
            redirect_to root_path if @group.blank?
            @contestant = Contestant.find_by(id: params[:id])
        end
end
