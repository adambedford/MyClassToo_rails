class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_one :college
  has_many :class_lists
  has_many :authentications, :dependent => :delete_all


  def apply_omniauth(omniauth)
  case omniauth['provider']
  when 'facebook'
    self.apply_facebook(omniauth)
  end
  authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :token =>(omniauth['credentials']['token'] rescue nil))
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def facebook
    @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token)
  end

  def facebook_friends
    @fb_friends ||= FbGraph::Query.new("SELECT uid, first_name, last_name, pic_square, profile_url FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1='#{self.authentications.find_by_provider('facebook').uid}')").fetch(self.authentications.find_by_provider('facebook').token)
  end


  protected

  def apply_facebook(omniauth)
    if (extra = omniauth['info']['raw_info'] rescue false)
      self.email = (extra['email'] rescue '')
    end
  end
end
