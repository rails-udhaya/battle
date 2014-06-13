class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,  :recoverable, :rememberable, :trackable, :validatable, :omniauthable #:confirmable,
  #~ , :token_authenticatable
  attr_accessible :email, :password, :password_confirmation, :name, :about, :remember_me, :locker_attributes, :role, :is_subscribed,:age, :gender, :dob,:avatar
  
  has_attached_file :avatar, :styles => { :icon=>"24x24>" ,:medium => "50x50>", :thumb => "100x100>" }, :default_url => "/assets/missing-image.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  validates_presence_of :email
  mount_uploader :image
  #~ , ImageUploader
  has_many :authorizations
  has_many :kids
  
  #~ after_create :add_user_to_subscription_list
  
  
  def add_user_to_subscription_list
    begin
      if self.is_subscribed ==  true
        gb = Gibbon::API.new("#{APP_CONFIG["mail_chimp_api_key"]}")
        gb.lists.subscribe({:id => "#{APP_CONFIG["mail_chimp_list_key"]}", :email => {:email => "#{self.email}"}, :merge_vars => {:FNAME => "#{self.name}", :LNAME => ''}, :double_optin => false})
      end
    rescue
    end
  end

  def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    if authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth["info"]["email"]).first : current_user
      if user.blank?
       user = User.new
       user.password = Devise.friendly_token[0,10]
       user.name = auth.info.name
       user.email = auth.info.email
       auth.provider == "twitter" ?  user.save(:validate => false) :  user.save
     end
     authorization.username = auth.info.nickname
     authorization.user_id = user.id
     authorization.save
   end
   authorization.user
 end
end

