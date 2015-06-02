class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,:confirmable
       
  mount_uploader :photo, ImageUploader
  
  class << self
    def from_omniauth(auth)
      user = User.where("provider = ? && uid = ?",auth.provider,auth.uid).first
      if user
        user.remote_photo_url = auth.info.image
        user.save
        puts user.errors.inspect
      else
        user = User.new        
        user.email = auth.info.email ? auth.info.email : auth.info.username
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.name
        user.remote_photo_url = auth.info.image
        user.token = auth.credentials.token
        user.save(:validate => false)
        user.confirm!
      end
      return user
    end
  end
end
