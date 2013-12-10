class Event

  include MongoMapper::Document

  key :title , String , :required => true
  key :venue , String
  key :event_date , Time
  key :latitude , Float
  key :longitude , Float
  key :last_comment_id , Integer
  key :last_picture_id , Integer
  key :created_by_name , String

  key :attendant_profile_images , Array

  key :expire_at , Time

  key :user_ids , Array

  key :created_by_profile_picture

  timestamps!

  auto_increment!

  many :users , :in => :user_ids

  many :comments, :as => :commentable
  many :pictures

  scope :active , where(:expire_at.gte => Time.now )

  belongs_to :user
  many :likes

  def expire_after
    x = (expire_at - Time.now)/3600
    hours = x.to_i/60
    minutes = x.to_i % 60
    "#{hours} hours and #{minutes} left"
  end

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
