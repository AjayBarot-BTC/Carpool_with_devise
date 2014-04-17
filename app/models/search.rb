class Search < ActiveRecord::Base

  belongs_to :user
  #belongs_to :request
  #validates :user_id, presence: true
  #validates :request_id, presence: true

  
#cases = cases.joins(:case_question_answers).where(case_question_answers: { question_option_id: case_params[:submitter_relationship] }) if case_params[:submitter_relationship].present?

  #def self.search(keywords)
   # searches = order(:name)
    #searches = Request.joins(:user)
   # searches = searches.where("name like ?", "%#{keywords}%") if keywords.present?
  #def users
  	#@users ||= find_users
  #end

  #def find_users
  	#users = User.order(:name)
  	#users = users.where("name like ?", "%#{keywords}%") if keywords.present?
  	#users
  #end

 # def self.search2(keywords)
  #  searches = order(:destination)
 #   searches = searches.where("destination like ?", "%#{keywords}%") if keywords.present?
 # end
end
