class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  has_many :plans_users, class_name: PlansUsers
  has_many :plans, through: :plans_users
  
  has_many :drill_users, class_name: DrillUsers
  has_many :drills, through: :drill_users

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.koala(auth)
   access_token = auth['token']
   facebook = Koala::Facebook::API.new(access_token)
   facebook.get_object("me?fields=name,picture")
 end
end
