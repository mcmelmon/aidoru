class Contest < ApplicationRecord
    has_many :contest_rankings, inverse_of: :contest, dependent: :destroy
    has_many :contestants, inverse_of: :contest, dependent: :destroy
    has_many :groups, inverse_of: :contest, dependent: :destroy
    has_many :most_liked_contestants, inverse_of: :contest, dependent: :destroy

    def current_period
        contest_rankings.pluck(:period).max
    end

    def generate_most_liked
        # TODO: when we have big enough numbers for likes, return the top 11.
        # For now, randomize everyone with any likes

        most_liked = Contestant.liked(self.id).map(&:id).shuffle.first(group_size)

        # TODO: someday we may want to preserve these, but we may also get to
        # "real time" updates
        most_liked_contestants.delete_all if most_liked_contestants.present?

        most_liked.each do |contestant_id|
            most_liked_contestants.create!(contest: self, contestant_id: contestant_id)
        end
    end

    def periods
        contest_rankings.pluck(:period).uniq.sort
    end

    def rankings_for_period(period)
        contest_rankings.where(period: period).order('rank').pluck(:contestant_id)
    end
end
