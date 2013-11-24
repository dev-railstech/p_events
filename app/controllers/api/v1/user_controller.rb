module Api
  module V1
    class UserController < ApplicationController
      def create

        if params[:fb_access_token].present? or params[:tw_access_token].present? or params[:ig_access_token].present?
          user = User.new
          user.name = params[:name]
          user.email = params[:email]
          user.sex = params[:sex]
          user.age = params[:age]
          user.country = params[:country]
          user.city = params[:city]
          user.latitude = params[:latitude]
          user.longitude = params[:longitude]
          user.fb_access_token = params[:fb_access_token]
          user.tw_access_token = params[:tw_access_token]
          user.ig_access_token = params[:ig_access_token]
          if user.save
            respond_to do |format|
              format.json { render :json => user }
            end
          else
            binding.pry
            respond_to do |format|
              format.json { render :json => { :message => 'Invalid data',:status => 121} }
            end
          end
        else
          response = { :message => 'Access token mission',:status => 120}
          respond_to do |format|
            format.json { render :json => response }
          end
        end


      end

    end

  end
end

