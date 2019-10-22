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

        liked = Contestant.liked(self.id).map {|c| [c.id, c.likes] }

        # find the lowest likes in the top N, where N is the contest group size
        lowest_likes_in_group = liked.first(group_size).map{ |c| c[1] }.min

        # where does the lowest number of likes in the top N start?
        first_group_index_of_lowest = liked.first(group_size).map{ |c| c[1] }.find_index(lowest_likes_in_group)

        # Start a new top N that does not include the lowest likes
        top_n = liked[0..first_group_index_of_lowest - 1]

        # where does the lowest number of likes in the top N stop in the full set of contestants?
        last_index_of_lowest = liked.find_index(lowest_likes_in_group > 0 ? lowest_likes_in_group - 1 : nil)
        last_index_of_lowest = last_index_of_lowest.present? ? last_index_of_lowest : liked.count + 1

        # Shuffle the contestants in the full group who have the lowest number of likes in the top N
        randomized_lowest = liked[first_group_index_of_lowest..last_index_of_lowest].shuffle

        # Fill out the top N with the shuffled contestants
        top_n = (top_n + randomized_lowest[0..(group_size - first_group_index_of_lowest - 1)]).map{ |c| c[0] }

        # TODO: someday we may want to preserve these, but we may also get to
        # "real time" updates
        most_liked_contestants.delete_all if most_liked_contestants.present?

        top_n.each do |contestant_id|
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
