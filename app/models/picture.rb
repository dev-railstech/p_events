class Picture

  include MongoMapper::EmbeddedDocument
  include Paperclip::Glue

  key :user_id , Integer , :required => true
  key :user_name , String
  key :created_by_profile_picture , String
  key :title , String , :required => true
  key :description , String
  key :latitude , Float
  key :longitude , Float
  key :last_comment_id , Integer

  key :image_url , String

  timestamps!

  many :comments

  many :likes

  belongs_to :event

  has_attached_file :avatar

  key :avatar_file_name, String

end
