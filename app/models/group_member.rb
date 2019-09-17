class GroupMember < ApplicationRecord
    belongs_to :contestant
    belongs_to :group

    validates_uniqueness_of :contestant, scope: :group
end