class User

  include MongoMapper::Document
  include Paperclip::Glue

  key :name , String , :required => true
  key :age , Integer , :numeric => true
  key :sex , String
  key :country , String
  key :city , String
  key :latitude , Float
  key :longitude , Float
  key :email , String , :required => true

  key :fb_access_token , String
  key :fb_link , String
  key :fb_id , String

  key :tw_access_token , String
  key :tw_link , String
  key :tw_id , String

  key :ig_access_token , String
  key :ig_link , String
  key :ig_id , String

  key :profile_image_url , String

  key :social_network

  key :event_ids , Array

  validates_uniqueness_of :email

  validate :access_token_presence

  def access_token_presence
    if fb_access_token.nil? and tw_access_token.nil? and ig_access_token.nil?
      errors.add :fb_access_token,"Should must provide atleast one access token"
    end
  end

  timestamps!

  auto_increment!

  one :role

  many :events  , :in => :event_ids

  def get_all_events
    #self.events.map {|event| event if event.expire_at > Time.now }.compact
    self.events.map {|event| event if event.is_active == true }.compact
  end

  def get_active_events
    self.events.active.order("event_date asc").all
  end

end
