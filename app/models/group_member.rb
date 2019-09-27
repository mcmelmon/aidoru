class GroupMember < ApplicationRecord
    belongs_to :contestant
    belongs_to :group

    validates_uniqueness_of :contestant, scope: :group

    scope :includes_member, -> (contestant_id) { where(contestant_id: contestant_id) }

    after_create :score_group
    after_destroy :score_group

    private
        def score_group
            group.score_group
        end
end