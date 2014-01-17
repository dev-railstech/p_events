class Like

  include MongoMapper::EmbeddedDocument

  key :user_id , String , :required => true
  key :user_id2 , Integer , :required => true

  key :created_by_profile_picture , String


  key :user_name , String

  timestamps!

  #auto_increment!

  belongs_to :picture

end
