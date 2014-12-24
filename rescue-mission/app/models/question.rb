class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

<<<<<<< HEAD
  validates :user_id, presence: true
  validates :title, length: { minimum: 50 }
  validates :description, length: { minimum: 150 }
=======
  validates :title, :description, :user_id, presence: true
  validates :title, length: { minimum: 40 }
  validates :description, length: { minimum: 140 }


>>>>>>> 6e871fb4e0efaf7d37fd2daf1218c52c13e64a73
end
