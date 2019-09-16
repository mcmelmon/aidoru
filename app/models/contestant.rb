class Contestant < ApplicationRecord
    has_many :performances, inverse_of: :contestant, dependent: :destroy

    accepts_nested_attributes_for :performances, allow_destroy: true
end
