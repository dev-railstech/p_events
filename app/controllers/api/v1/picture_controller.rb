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

      def comment
        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i

        post_id = params[:post_id]
        event_post = event.pictures.select{|e| e if e.id.to_s == post_id }
        post =event_post.first

        p_comment = Comment.new
        p_comment.user_id = user.id
        p_comment.user_id2 = user.id2
        p_comment.user_name = user.name
        p_comment.created_by_profile_picture = user.profile_image_url
        p_comment.comment_text = params[:comment_text]
        p_comment.save

        post.comments << p_comment

        post.save

        respond_to do |format|
          format.json { render :json => {status: "Ok"} }
        end

      end

      def like
        user = User.find_by_id2 params[:user_id].to_i
        event = Event.find_by_id2 params[:event_id].to_i

        post_id = params[:post_id]
        event_post = event.pictures.select{|e| e if e.id.to_s == post_id }
        post =event_post.first

        p_like = post.likes.select{|l| l if l.user_id == user.id.to_s }
        if p_like.present?

          post.likes.delete_if {|l| l.user_id == user.id.to_s }
          post.save
          response = {status: "unliked"}
        else
          p_like = Like.new
          p_like.user_id = user.id
          p_like.user_id2 = user.id2
          p_like.user_name = user.name
          p_like.created_by_profile_picture = user.profile_image_url
          p_like.save

          post.likes << p_like

          post.save

          response = {status: "liked"}

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
        user = User.find_by_id2 params[:user_id].to_i

        response = { :message => 'An unknown error prohibits saving this picture' , :status => 116 }

        if event.present?
          picture = Picture.new(params)
          picture.user_name = user.name
          picture.created_by_profile_picture = user.profile_image_url
          picture.save
          picture.image_url = picture.avatar
          picture.save
          event.pictures << picture
          event.save
          response = { :message => 'Picture saved successfully' , :status => 0 , :picture_url => picture.avatar }
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

