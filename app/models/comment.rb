class Comment

  include MongoMapper::Document

  key :user_id , Integer , :required => true
  key :user_name , String
  key :text , String , :required => true

  timestamps!

  auto_increment!

  belongs_to :commentable, :polymorphic => true

end
