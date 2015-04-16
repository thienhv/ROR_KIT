class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
  :registerable,
  :recoverable, 
  :rememberable, 
  :trackable, 
  :validatable, 
  :confirmable,
  :omniauthable, 
  :omniauth_providers => [:facebook]

  after_create :send_mail_welcome

  def send_mail_welcome
  	# UserMailer.welcome_email(self).deliver_now
  end


  def self.from_omniauth(auth)
    where(provider: auth.provider).where(uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      # user.password = auth.info.email
      user.save(validate: false)
    end
  end

end
