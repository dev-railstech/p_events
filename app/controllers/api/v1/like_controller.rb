module Api
  module V1

    class LikeController < ApplicationController

      def like_event
        user = User.find_by_id2 params[:user_id]
        event = Event.find_by_id2 params[:event_id]
        response = {:message => 'Unable to find requested user/event',:status => 151}
        if user.present? and event.present?
          like = Like.new
          like.user_id = user.id2
          like.user_name = user.name
          like.save
          event.likes << like
          event.save
          response = {:message => 'Event liked',:status => 200}
        end
        respond_to do |format|
          format.json { render :json => response }
        end
      end

      def unlike_event

      end
    end

  end
end
