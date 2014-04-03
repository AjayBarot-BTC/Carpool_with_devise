class Request < ActiveRecord::Base
	belongs_to :user

	#def self.search(keywords)
		#requests = order(:destination)
		#requests = requests.where("destination LIKE ?", "%#{keywords}%") if keywords.present?
		#requests = requests.where(user_id: user_id) if user_id.present?
		#requests
	#end

	#private

  #def find_requests
   # requests = Request.order(:destination)
    #requests = requests.where("destination LIKE?", "%#{keywords}%") if keywords.present?
    
    #requests
  #end
	#def destination
	#	user.destination if user		
	#end

	#def destination=(destination)
	#	self.user = User.find_or_create_by_destination(destination) unless destination.blank?				
	#end

	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true
	validates :destination, presence: true
	validates :source, presence: true;
	validates :date, presence: true;
	validates :time, presence: true;
	def self.from_users_followed_by(user)
    	followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id" 
    	where("user_id IN (#{ followed_user_ids }) OR user_id = :user_id", user_id: user.id)
  	end
end