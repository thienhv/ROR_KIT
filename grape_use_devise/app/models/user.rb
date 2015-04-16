class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 has_one :api_key
 after_create :create_api_key


 private
 def create_api_key
 	ApiKey.create(user_id: self.id)
 end
end
