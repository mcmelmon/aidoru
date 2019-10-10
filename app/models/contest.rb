class Contest < ApplicationRecord
    has_many :contest_rankings, inverse_of: :contest, dependent: :destroy
    has_many :groups, inverse_of: :contest, dependent: :destroy

    def current_period
        contest_rankings.pluck(:period).max
    end

    def periods
        contest_rankings.pluck(:period).uniq.sort
    end

    def rankings_for_period(period)
        contest_rankings.where(period: period).order('rank').pluck(:contestant_id)
    end
end
