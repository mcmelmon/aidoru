class ContactMessagesController < ApplicationController
    def create
        @message = ContactMessage.new(contact_message_params)
        if @message.save
            flash[:notice] = 'Message sent!'
            redirect_to about_path
        else
            flash[:error] = 'There was a problem'
            redirect_to about_path
        end
    end

    private
        def contact_message_params
            params.require(:contact_message).permit(:email, :message).tap do |clean_params|
                clean_params[:email] = Rails::Html::FullSanitizer.new.sanitize(clean_params[:email])
                clean_params[:message] = Rails::Html::FullSanitizer.new.sanitize(clean_params[:message])
              end
        end
end