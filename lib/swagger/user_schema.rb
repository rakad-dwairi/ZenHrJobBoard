class Swagger::UserSchema
    include Swagger::Blocks
  
    swagger_schema :UserInput do
      property :email do
        key :type, :string
      end
  
      property :password do
        key :type, :string
      end
  
      property :admin do
        key :type, :boolean
      end
    end
  end
  