class MostLikedContestant < ApplicationRecord
    belongs_to :contest, inverse_of: :most_liked_contestants
    belongs_to :contestant, inverse_of: :most_liked_contestant
end