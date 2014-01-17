class EventsController < ApplicationController


  def index
    @user = User.find_by_id params[:user_id]
    @events = []
    if @user.present?
      @events = @user.get_all_events
    end
  end

  def show

    @user = User.find_by_id params[:user_id]
    @event = Event.find_by_id params[:event_id]

  end

end
