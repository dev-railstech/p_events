class Comment

  include MongoMapper::EmbeddedDocument

  key :user_id , Integer , :required => true
  key :user_name , String
  key :comment_text , String

  timestamps!

  #auto_increment!

end
