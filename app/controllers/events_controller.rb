class EventsController < ApplicationController


  def index
    @user = User.find_by_id params[:user_id]
    @events = []
    if @user.present?
      @events = @user.get_all_events
    end
  end

  def show
    @event = Event.last #find_by_id params[:id]
    redirect_to stream_event_path(@event)
  end

  def stream
    @event = Event.find_by_id params[:id]
  end

  def gallery
    @event = Event.find_by_id params[:id]
  end

  def location
    @event = Event.find_by_id params[:id]
  end

  def stats
    @event = Event.find_by_id params[:id]
  end

end
