class Group < ApplicationRecord
    belongs_to :contest
    belongs_to :user

    has_many :group_members, inverse_of: :group, dependent: :destroy
    has_many :contestants, through: :group_members

    validates_presence_of :contest_id
    validates_presence_of :user_id

    scope :includes_contestant, -> (contestant_id) { Group.joins(:group_members).merge(GroupMember.includes_member(contestant_id)) }


    self.per_page = 10

    def center
        Contestant.find_by(id: center_id)
    end

    def destroy
        contestants.each { |contestant| contestant.remove_from_group(self) }
        super()
    end

    def has_room
        contestants.count < contest.group_size
    end

    def includes_member(contestant_id)
        contestants.where(id: contestant_id).present?
    end

    def is_active_for(user)
        id == user.current_group&.id
    end

    def ordered_contestants
        members = contestants.where.not(id: center_id).to_a
        center.present? ? members.unshift(center) : members
    end

    def random_member
        contestants.to_a.shuffle.first
    end
end
