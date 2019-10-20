class ContestRanking < ApplicationRecord
    belongs_to :contest, inverse_of: :contest_rankings
    belongs_to :contestant, inverse_of: :contest_rankings

    validates_uniqueness_of :period, scope: :contestant_id
    validates_uniqueness_of :rank, scope: :period
end