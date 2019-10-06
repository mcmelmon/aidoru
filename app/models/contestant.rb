class Contestant < ApplicationRecord
    belongs_to :contest, optional: true
    has_many :contest_rankings, inverse_of: :contestant, dependent: :destroy
    has_many :group_adds, inverse_of: :contestant, dependent: :destroy
    has_many :group_members, inverse_of: :contestant, dependent: :destroy
    has_many :group_removes, inverse_of: :contestant, dependent: :destroy
    has_many :performances, inverse_of: :contestant, dependent: :destroy

    has_many :groups, through: :group_members

    accepts_nested_attributes_for :performances, allow_destroy: true
    accepts_nested_attributes_for :contest_rankings, allow_destroy: true

    def add_to_group(group)
        if group.has_room
            group.group_members.create!(contestant: self)
            group_adds.create!(group_id: group.id)
        end
    end

    def current_period
        contest_rankings.pluck(:period).max
    end

    def current_rank
        contest_rankings.where(period: current_period).first.rank
    end

    def is_center_for(group)
        group.center_id == self.id
    end

    def make_center(group)
        group.update_attribute(:center_id, self.id)
    end

    def rank_for_period(period)
        contest_rankings.where(period: period).first&.rank
    end

    def remove_from_group(group)
        group.update_attribute(:center_id, nil) if group.center == self
        group.group_members.find_by(contestant: self).destroy
        group_removes.create!(group_id: group.id)
        group.score_group
    end
end
