class HomeController < ApplicationController
    def about
        @message = ContactMessage.new
    end

    def index
        # TODO: only one contest now, but this will need to be dynamic
        period = params[:selected_period].present? ? params[:selected_period] : Contest.first.current_period
        ranked_contestant_ids = Contest.first.rankings_for_period(period)
        current_group_ids = current_user.present? && current_user.current_group.present? ? current_user.current_group.contestants.pluck(:id) : []
        @contestant_ids = ranked_contestant_ids - current_group_ids
        render :homepage
    end
end