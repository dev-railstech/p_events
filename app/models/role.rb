class Role

  include MongoMapper::Document

  key :role_name , String ,:required => true

end
