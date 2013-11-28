module Api
  module V1
    class UserController < ApplicationController
      def create
        if params[:email].present? and (params[:fb_access_token].present? or params[:tw_access_token].present? or params[:ig_access_token].present?)
          user = User.find_by_email(params[:email])
          if user.present?
            respond_to do |format|
              format.json { render :json => user }
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

            if params[:fb_access_token].present?
              user.fb_access_token = params[:fb_access_token]
              user.fb_link = params[:fb_link]
              user.fb_id = params[:fb_id]
            end

            if params[:tw_access_token].present?
              user.tw_access_token = params[:tw_access_token]
              user.tw_link = params[:tw_link]
              user.tw_id = params[:tw_id]
            end

            if params[:ig_access_token].present?
              user.ig_access_token = params[:ig_access_token]
              user.ig_link = params[:ig_link]
              user.ig_id = params[:ig_id]
            end

            if user.save
              respond_to do |format|
                format.json { render :json => user }
              end
            else
              respond_to do |format|
                format.json { render :json => { :message => 'Invalid data',:status => 121} }
              end
            end
          end

        else
          response = { :message => 'Missing data',:status => 120}
          respond_to do |format|
            format.json { render :json => response }
          end
        end


      end

    end

  end
end

