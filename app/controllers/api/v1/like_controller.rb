module Api
  module V1

    class LikeController < ApplicationController

      def like_event
        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i
        response = {:message => 'Unable to find requested user/event',:status => 151}
        if user.present? and event.present?
          if event.likes.find_by_user_id(user.id2).present?
            like = event.likes.find_by_user_id(user.id2)
            like.delete
            response = {:message => 'Event unliked',:status => 200}
          else
            like = Like.new
            like.user_id = user.id2
            like.user_name = user.name
            like.save
            event.likes << like
            event.save
            response = {:message => 'Event liked',:status => 200}
          end
        end
        respond_to do |format|
          format.json { render :json => response }
        end
      end

      def event_likes
        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i
        response = {:message => 'Unable to find requested user/event',:status => 151}
        if user.present? and event.present?
          response = { :likes => event.likes , :liked => event.likes.find_by_user_id(user.id2).present? ,:count => event.likes.count }
        end
        respond_to do |format|
          format.json { render :json => response }
        end
      end

    end

  end
end
