class Contestant < ApplicationRecord
    belongs_to :contest, optional: true
    has_many :group_members, inverse_of: :contestant, dependent: :destroy
    has_many :groups, through: :group_members
    has_many :performances, inverse_of: :contestant, dependent: :destroy

    accepts_nested_attributes_for :performances, allow_destroy: true
end
