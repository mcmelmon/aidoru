class UsersController < ApplicationController
    def groups
        @groups = current_user.groups.page(params[:page]).order('updated_at DESC')
        render 'users/groups'
    end
end