class CommentController < ApplicationController

  def create_event_comment

    user = User.find_by_id2 params[:user_id].to_i
    event = Event.find_by_id2 params[:event_id].to_i

    response = { :message => 'Event not found' , :status => 100 }

    if event
      comment = event.comments.new
      comment.text = params[:comment]
      comment.user_id = user.id2
      comment.user_name = user.name
      response[:message] = "Comment posted successfully"
      response[:status] = 0
    end

    respond_to do |format|
      format.json { render :json => response }
    end

  end

  def get_event_comments

    user = User.find_by_id2 params[:user_id].to_i
    event = Event.find_by_id2 params[:event_id] .to_i

    response = { :message => 'Event not found' , :status => 101 }

    if event.present?
      response = event.comments.new
    end

    respond_to do |format|
      format.json { render :json => response }
    end

  end

  def create_picture_comment

    user = User.find_by_id2 params[:user_id].to_i
    event = Event.find_by_id2 params[:event_id].to_i
    picture = Picture.find_by_id2 params[:picture_id].to_i

    response = { :message => 'Picture not found' , :status => 102 }

    if event
      comment = picture.comments.new
      comment.text = params[:comment]
      comment.user_id = user.id2
      comment.user_name = user.name
      response[:message] = "Comment posted successfully"
      response[:status] = 0
    end

    respond_to do |format|
      format.json { render :json => response }
    end

  end

  def get_picture_comment

    user = User.find_by_id2 params[:user_id].to_i
    event = Event.find_by_id2 params[:event_id].to_i
    picture = Picture.find_by_id2 params[:picture_id].to_i

    response = { :message => 'Picture not found' , :status => 103 }

    if picture.present?
      response = picture.comments.new
    end

    respond_to do |format|
      format.json { render :json => response }
    end

  end

end
