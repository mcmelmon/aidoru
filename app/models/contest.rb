class Contest < ApplicationRecord
    has_many :groups, inverse_of: :contest, dependent: :destroy
end
