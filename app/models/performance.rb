class Performance < ApplicationRecord
    belongs_to :contestant, inverse_of: :performances

    validates_uniqueness_of :youtube_video_id, scope: :contestant_id
end
