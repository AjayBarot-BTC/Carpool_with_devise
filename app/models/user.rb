class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
mount_uploader :image, ImageUploader

acts_as_messageable

geocoded_by :current_sign_in_ip
after_validation :geocode

devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

validates :name, presence: true, length: {maximum: 50}
#VALID_EMAIL_REGEX = /\A[\W+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, uniqueness: { case_sensitive: false }

has_many :searches

has_many :requests, dependent: :destroy

#for follwer and following

has_many :relationships, foreign_key: "follower_id", dependent: :destroy

has_many :followed_users, through: :relationships, source: :followed

has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent: :destroy

has_many :followers, through: :reverse_relationships, source: :follower

#for messages
#has_many :messages
#has_many :sent_messages, class_name: "Message", foreign_key: "user_id", dependent: :destroy
#has_many :received_messages, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy
#has_many :sender, class_name: "User", foreign_key: "user_id"

#has_many :received, class_name: "User", foreign_key: "receiver_id"

#validates :password, length: { minimum: 6 }

def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids where("user_id IN (:followed_user_ids) OR user_id = :user_id", followed_user_ids: followed_user_ids, user_id: user)
end

def self.search(keywords)

  users = order(:name)
  #@users = User.joins([:requests]).where("name LIKE ? OR destination LIKE ?","#{keywords}%","#{keywords}%")
  #users = users.select("*").joins(:requests)
  #users = users.where("name OR destination = ?", "%#{keywords}%") if keywords.present?
  #users = Request.joins(:user).where("name LIKE ? OR destination LIKE ?", "#{keywords}%","#{keywords}%") if keywords.present?

  #users = User.where("name OR destination LIKE ?", "%#{keywords}%") if keywords.present?
  #puts "-----------------------#{keywords.inspect}"
  #cases = cases.joins(:case_question_answers).where(case_question_answers: { question_option_id: case_params[:submitter_relationship] }) if case_params[:submitter_relationship].present?
    #if params[:search]
     
      #@users = User.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
     
     # @users = User.paginate(:page => params[:page], :per_page => 5, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    #else
      #@users = User.find(:all)
     
      #@users = User.paginate(:page => params[:page], :per_page => 5, :conditions => ['name LIKE ?', "%#{params[:search]}%"])      
    #end
  end

def feed
  Request.from_users_followed_by(self)	
end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

def feed
	 Request.where("user_id = ?", id)
end

end
