module Api
  module V1
    class EventController < ApplicationController

      def index

        user = User.find_by_id2 params[:user_id].to_i

        response = { :message => 'Failed to fetch events for specified user' , :status => 104 }
        #binding.pry
        if user.present?
          #response = Event.where(:user_id => user.id, :expire_at.gt => Time.now)
          response = user.get_all_events
        end

        respond_to do |format|
          format.json { render :json => response }
        end

      end

      def show

        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i

        response = { :message => 'Failed to fetch event by specified event id' , :status => 109 }

        response = event if event.present?

        respond_to do |format|
          format.json { render :json => response }
        end

      end

      def stats

        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i

        response = { :message => 'Failed to fetch event by specified event id' , :status => 109 }

        if event.present?
          statistics = { event: event}
          statistics[:total_participants] = event.users.length
          male_participants = 0
          event.users.each {|u| male_participants = male_participants + 1 if u.sex == "male" }
          statistics[:male_participants] = male_participants
          statistics[:female_participants] = event.users.length - male_participants
          response = statistics
        end

        respond_to do |format|
          format.json { render :json => response }
        end

      end

      def post
        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i
        post_id = params[:post_id]

        event_post = event.pictures.select{|e| e if e.id.to_s == post_id }
        p_like = event_post.first.likes.select{|l| l if l.user_id == user.id.to_s }

        response = { post: event_post.first , liked: p_like.present? }
        respond_to do |format|
          format.json { render :json => response }
        end


      end

      def remove

        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i

        response = { :message => 'Failed to fetch event by specified event id' , :status => 110 }

        if event.present?
          event.delete
          response = { :message => 'Event deleted successfully' , :status => 0 }
        end

        respond_to do |format|
          format.json { render :json => response }
        end

      end

      def im_in
        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i
        unless event.im_in.include?(user.id2)
          event.im_in << user.id2
          event.attendant_profile_images << user.profile_image_url
          event.im_in_names << user.name
        end
        event.save
        response = { :message => 'User step into event successfully' , :status => 200 }
        respond_to do |format|
          format.json { render :json => response }
        end
      end

      def im_out                                            s
        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i
        event.im_in.delete(user.id2)
        event.attendant_profile_images.delete(user.profile_image_url)
        event.im_in_names.delete(user.name)
        event.save
        response = { :message => 'User out of event successfully' , :status => 200 }
        respond_to do |format|
          format.json { render :json => response }
        end
      end

      def create

        user = User.find_by_id2 params[:user_id].to_i

       if user.present?

          event = Event.new(params)
          #@event.title = params[:title]
          #@event.venue = params[:venue]
          #@event.event_date = Time.parse(params[:event_date])
          #@event.latitude = params[:latitude]
          #@event.longitude = params[:longitude]
          #@event.save
          #binding.pry
          event.created_by_name = user.name
          event.created_by_profile_picture = user.profile_image_url
          event.user = user
          event.users << user
          event.expire_at = Time.parse(params[:event_date]) + params[:expire_after].to_i.hours
          #@event.cover_photo = @event.cover_pic
          event.im_in << user.id2
          event.attendant_profile_images << user.profile_image_url
          event.save

          event.cover_photo = event.cover_pic
          event.save
          respond_to do |format|
              user.events << event
              user.save
              format.json { render :json => event }
          end
        else
          respond_to do |format|
            format.json { render :json => { :message => 'Failed to create event' , :status => 105 } }
          end
        end

      end

      def invite

        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i

        response = { :message => 'Failed to invite users' , :status => 104 }

        if event.present?

            user_invited = User.find_by_email params[:email]
            if user_invited.present?
              user_invited.events << event
              event.users << user_invited
              #event.attendant_profile_images << user_invited.profile_image_url
              user_invited.save
              Notifier.notify_user(user,params[:email],event).deliver
            else
              #binding.pry
              #use mailer to send invitation email alongwith app link
              Notifier.invitation(user,params[:email],event).deliver
            end

          event.save
          response = { :message => 'User invited successfully' , :status => 0 } if event.save
        end

        respond_to do |format|
          format.json { render :json => response }
        end

      end

      def invite_backup

        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i

        response = { :message => 'Failed to invite users' , :status => 104 }
        binding.pry
        if event.present?
          params[:user_ids].each do |user_id|
            user_invited = User.find_by_id2 user_id.to_i
            if user_invited.present?
              user_invited.events << event
              event.users << user_invited
              user_invited.save
            end
          end
          event.save
          response = { :message => 'User invited successfully' , :status => 0 } if event.save
        end

        respond_to do |format|
          format.json { render :json => response }
        end

      end


    end

  end
end
