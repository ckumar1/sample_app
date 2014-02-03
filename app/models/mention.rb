class Mention < ActiveRecord::Base
   belongs_to :user, class_name: "User"
   belongs_to :micropost, class_name: "Micropost"
  validates :user_id, presence: true
  validates :micropost_id, presence: true
end
