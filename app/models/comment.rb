class Comment

  include MongoMapper::EmbeddedDocument

  key :user_id , String , :required => true
  key :user_id2 , Integer , :required => true

  key :user_name , String
  key :comment_text , String

  key :created_by_profile_picture , String

  timestamps!

  #auto_increment!

end
