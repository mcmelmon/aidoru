class Group < ApplicationRecord
    belongs_to :contest
    belongs_to :user

    validates_presence_of :contest_id
    validates_presence_of :user_id
end
