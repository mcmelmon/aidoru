class GroupsController < ApplicationController
    require 'will_paginate/array'

    before_action :authenticate_user!, only: [:add_random_members, :destroy, :edit, :make_current_group, :new, :update]
    before_action :correct_user, only: [:add_random_members, :destroy, :edit, :make_current_group, :update]

    def add_random_members
        open_positions = @group.contest.group_size - @group.contestants.count
        members = Contestant.where.not(id: @group.contestants.map(&:id))
            .to_a
            .shuffle!(random: Random.new(Time.now.to_i))
            .first(open_positions)
        members.each do |member|
            member.add_to_group(@group)
        end
        redirect_to edit_group_path(@group)
    end

    def create
        @group = current_user.groups.build(group_params)
        if @group.save
            current_user.update_attribute(:current_group_id, @group.id)
            Contestant.find_by(id: params[:contestant_id]).add_to_group(@group) if params[:contestant_id].present?
            flash[:notice] = 'Your group was created.'
            redirect_to group_path(@group)
        else
            flash[:error] = 'There was a problem'
            redirect_to new_group_path
        end
    end

    def destroy
        available_groups = current_user.groups.where.not(id: @group.id)
        current_user.update_attribute(:current_group_id, available_groups.first&.id) if @group == current_user.current_group
        @group.destroy
        flash[:notice] = 'Group deleted.'
        redirect_to root_path
    end

    def edit
    end

    def index
        # TODO: this is lol, but it's accurate; figure out the join/merge magic
        ranked_group_ids = Group.all.map {|c| [c.id, c.current_score] }.sort{|a,b| b[1] <=> a[1]}.map{|c| c[0]}[0..100]
        @groups = ranked_group_ids.map { |id| Group.find_by(id: id) }
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
