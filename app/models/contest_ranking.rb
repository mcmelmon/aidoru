class ContestRanking < ApplicationRecord
    belongs_to :contestant, inverse_of: :contest_rankings

    validates_uniqueness_of :period, scope: :contestant_id
end