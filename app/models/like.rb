class Like

  include MongoMapper::Document

  key :user_id , Integer , :required => true
  key :user_name , String

  timestamps!

  auto_increment!

  belongs_to :event

end
