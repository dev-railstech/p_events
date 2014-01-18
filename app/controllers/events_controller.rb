class EventsController < ApplicationController


  def index
    @user = User.find_by_id params[:user_id]
    @events = []
    if @user.present?
      @events = @user.get_all_events
    end
  end

  def show

    @event = Event.find_by_id params[:id]

  end

end
