class Group < ApplicationRecord
    belongs_to :contest
    belongs_to :user

    has_many :group_members, inverse_of: :group, dependent: :destroy
    has_many :group_scores, inverse_of: :group, dependent: :destroy
    has_many :contestants, through: :group_members

    validates_presence_of :contest_id
    validates_presence_of :user_id

    scope :includes_contestant, -> (contestant_id) { Group.joins(:group_members).merge(GroupMember.includes_member(contestant_id)) }

    after_update :update_group_score

    self.per_page = 10

    def self.score_groups
        where(contest_id: 1).each do |group|
            group.score_group
        end
    end

    def center
        Contestant.find_by(id: center_id)
    end

    def current_score
        current_period = group_scores.pluck(:period).max
        group_scores.present? ? group_scores.where(period: current_period).first.score : 0
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

    def score_group
        score = 0
        contestants.each do |contestant|
            score += (101 - contestant.current_rank)
            score += 100 if contestant.current_rank == 1
        end

        current_period = contestants.blank? ? current_period = 1 : contestants.first.current_period
        group_score = group_scores.where(period: current_period).first

        if group_score.present?
            group_score.update_attribute(:score, score)
        else
            group_scores.create!(period: current_period, score: score)
        end
    end

    private
        def update_group_score
            score_group
        end
end
