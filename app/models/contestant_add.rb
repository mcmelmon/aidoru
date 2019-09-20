class ContestantAdd < ApplicationRecord
    belongs_to :contestant
    belongs_to :group
end