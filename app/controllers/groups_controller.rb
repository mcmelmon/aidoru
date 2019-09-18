class GroupsController < ApplicationController
    before_action :authenticate_user!, only: [:destroy, :edit, :make_current_group, :update]
    before_action :correct_user, only: [:destroy, :edit, :make_current_group, :update]

    def create
        @group = current_user.groups.build(group_params)
        if @group.save
            current_user.update_attribute(:current_group_id, @group.id)
            flash[:notice] = 'Your group was created.'
            redirect_to group_path(@group)
        else
            flash[:error] = 'There was a problem'
            redirect_to new_group_path
        end
    end

    def destroy
        @group.destroy
        flash[:notice] = 'Group deleted.'
        redirect_to root_path
    end

    def edit
    end

    def index
        @groups = current_user.groups
    end

    def make_current_group
        current_user.update_attribute(:current_group_id, @group.id)
        redirect_to group_path(@group)
    end

    def new
        @group = Group.new()
    end

    def show
        @group = Group.find_by(id: params[:id])
    end

    def update
        if @group.update(group_params)
            flash[:notice] = 'Group updated.'
            redirect_to group_path(@group)
        else
            flash[:error] = 'There was a problem'
            redirect_to edit_group_path
        end
    end

    private

        def group_params
            params.require(:group).permit(:center_id, :contest_id, :description, :name, :user_id).tap do |clean_params|
                clean_params[:contest_id] = Contest.first.id
                clean_params[:description] = Rails::Html::FullSanitizer.new.sanitize(clean_params[:description])
                clean_params[:name] = Rails::Html::FullSanitizer.new.sanitize(clean_params[:name])
              end
        end

        def correct_user
            @group = current_user.groups.find_by(id: params[:id])
            redirect_to root_url if @group.nil?
         end
end
