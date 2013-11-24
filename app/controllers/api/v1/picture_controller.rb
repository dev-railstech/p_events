module Api
  module V1
    class PictureController < ApplicationController

      def index

        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i

        response = { :message => 'Failed to fetch event of user specified by id' , :status => 106 }
        if event.present?
          response = event.pictures
        end

        respond_to do |format|
          format.json { render :json => response }
        end

      end

      def show

        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i
        picture = Picture.find_by_id2 params[:picture_id].to_i

        response = { :message => 'Failed to fetch event by given event id' , :status => 107 }

        response = picture if picture.present?


        respond_to do |format|
          format.json { render :json => response }
        end

      end

      def create

        event = Event.find_by_id2 params[:event_id].to_i

        response = { :message => 'An unknown error prohibits saving this picture' , :status => 116 }

        if event.present?
          event.pictures.create(params)
          response = { :message => 'Picture saved successfully' , :status => 0 }
        end

        respond_to do |format|
          format.json { render :json => response }
        end

      end

      def remove

        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i
        picture = Picture.find_by_id2 params[:picture_id].to_i

        response = { :message => 'Failed to delete picture' , :status => 108 }

        if picture.present?
          picture.delete
          response = { :message => 'Picture deleted successfully' , :status => 0 }
        end


        respond_to do |format|
          format.json { render :json => response }
        end

      end

    end

  end
end

