class Contestant < ApplicationRecord
    belongs_to :contest, optional: true
    has_many :contestant_adds, inverse_of: :contestant, dependent: :destroy
    has_many :contestant_removes, inverse_of: :contestant, dependent: :destroy
    has_many :group_members, inverse_of: :contestant, dependent: :destroy
    has_many :performances, inverse_of: :contestant, dependent: :destroy

    has_many :groups, through: :group_members

    accepts_nested_attributes_for :performances, allow_destroy: true

    def add_to_group(group)
        group.group_members.create!(contestant: self)
        contestant_adds.create!(group_id: group.id)
    end

    def is_center_for(group)
        group.center_id == self.id
    end

    def make_center(group)
        group.update_attribute(:center_id, self.id)
    end

    def remove_from_group(group)
        group.update_attribute(:center_id, nil) if group.center == self
        group.group_members.find_by(contestant: self).destroy
        contestant_removes.create!(group_id: group.id)
    end
end
