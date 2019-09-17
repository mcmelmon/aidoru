class Group < ApplicationRecord
    belongs_to :contest
    belongs_to :user

    has_many :group_members, inverse_of: :group, dependent: :destroy
    has_many :contestants, through: :group_members

    validates_presence_of :contest_id
    validates_presence_of :user_id
end
