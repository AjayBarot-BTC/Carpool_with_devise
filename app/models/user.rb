class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
mount_uploader :image, ImageUploader

devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

validates :name, presence: true, length: {maximum: 50}
#VALID_EMAIL_REGEX = /\A[\W+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, uniqueness: { case_sensitive: false }

#for follwer and following
has_many :requests, dependent: :destroy

has_many :destination

has_many :relationships, foreign_key: "follower_id", dependent: :destroy

has_many :followed_users, through: :relationships, source: :followed

has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent:   :destroy

has_many :followers, through: :reverse_relationships, source: :follower

validates :password, length: { minimum: 6 }

def search(search)
      if search
          find(:all, :conditions => ['destination LIKE ?', "%#{search}%"])
      else
          find(:all) 
      end
  end
def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (:followed_user_ids) OR user_id = :user_id",
          followed_user_ids: followed_user_ids, user_id: user)
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
