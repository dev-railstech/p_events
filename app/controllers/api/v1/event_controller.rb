module Api
  module V1
    class EventController < ApplicationController

      def index

        user = User.find_by_id2 params[:user_id].to_i

        response = { :message => 'Failed to fetch events for specified user' , :status => 104 }

        if user.present?
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

      def create

        user = User.find_by_id2 params[:user_id].to_i

       if user.present?
          @event = Event.new
          @event.title = params[:title]
          @event.venue = params[:venue]
          @event.event_date = params[:event_date]
          @event.latitude = params[:latitude]
          @event.longitude = params[:longitude]
          @event.created_by_name = user.name
          @event.user = user
          respond_to do |format|
            if @event.save
              user.events << @event
              user.save
              format.json { render :json => @event }
            else
              format.json { render :json => { :message => 'Invalid data' , :status => 123 } }
            end
          end
        else
          respond_to do |format|
            format.json { render :json => { :message => 'Failed to create event' , :status => 105 } }
          end
        end
      end

      def invite

        user = User.find_by_id2 params[:user_id].to_i
        event = User.find_by_id2 params[:event_id].to_i

        response = { :message => 'Failed to invite users' , :status => 104 }

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
