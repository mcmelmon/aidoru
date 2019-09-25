module ContestantsHelper
    def can_add_contestant_to_current_group(contestant)
        user_signed_in? && current_user.current_group.present? && !current_user.current_group.includes_member(contestant) && current_user.current_group.has_room
    end
end
