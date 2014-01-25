module Api
  module V1
    class UserController < ApplicationController

      def create
        if params[:email].present? and (params[:fb_access_token].present? or params[:tw_access_token].present? or params[:ig_access_token].present?)
          user = User.find_by_email(params[:email])
          if user.present?
            respond_to do |format|
              format.json
            end
          else
            user = User.new
            user.name = params[:name]
            user.email = params[:email]
            user.sex = params[:sex]
            user.age = params[:age]
            user.country = params[:country]
            user.city = params[:city]
            user.latitude = params[:latitude]
            user.longitude = params[:longitude]
            user.profile_image_url = params[:profile_image_url]

            if params[:fb_access_token].present?
              user.fb_access_token = params[:fb_access_token]
              user.fb_link = params[:fb_link]
              user.fb_id = params[:fb_id]
              user.social_network = 'Facebook'
            end

            if params[:tw_access_token].present?
              user.tw_access_token = params[:tw_access_token]
              user.tw_link = params[:tw_link]
              user.tw_id = params[:tw_id]
              user.social_network = 'Twitter'
            end

            if params[:ig_access_token].present?
              user.ig_access_token = params[:ig_access_token]
              user.ig_link = params[:ig_link]
              user.ig_id = params[:ig_id]
              user.social_network = 'Instagram'
            end

            if user.save
              respond_to do |format|
                format.json
              end
            else
              respond_to do |format|
                format.json
              end
            end
          end

        else
          response = { :message => 'Missing data',:status => 120}
          respond_to do |format|
            format.json
          end
        end


      end

      def show
        user = User.find_by_id2 params[:id].to_i
        respond_to do |format|
          format.json
        end
      end

      def health
        render :text => 'hellow hwe OK werguhew'
      end

    end

  end
end

