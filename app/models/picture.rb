class Picture

  include MongoMapper::Document
  include Paperclip::Glue


  key :user_id , Integer , :required => true
  key :title , String , :required => true
  key :description , String
  key :latitude , Float
  key :longitude , Float
  key :last_comment_id , Integer

  timestamps!

  auto_increment!

  many :comments, :as => :commentable
  belongs_to :event

  has_attached_file :avatar

  key :avatar_file_name, String
                         #   :storage        => :s3,
                          #  :s3_credentials => File.join(Rails.root, 'config', 's3.yml')

end
