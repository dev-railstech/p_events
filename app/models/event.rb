class Event

  include MongoMapper::Document

  key :title , String , :required => true
  key :venue , String
  key :event_date , DateTime
  key :latitude , Float
  key :longitude , Float
  key :last_comment_id , Integer
  key :last_picture_id , Integer
  key :created_by_name , String

  key :user_ids , Array

  timestamps!

  auto_increment!

  many :users , :in => :user_ids
  many :comments, :as => :commentable
  many :pictures

  belongs_to :user

  def organizer
    self.user
  end

  def participants
    participants = self.users
    participants << self.user
    participants
  end

  def male_participants
    self.participants.all(:sex => "m")
  end

  def female_participants
    self.participants.all(:sex => "f")
  end

end
