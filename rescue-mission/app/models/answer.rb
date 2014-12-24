class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

<<<<<<< HEAD
  validates :description, length: { minimum: 50 }
  validates :user_id, presence: true
  validates :question_id, presence: true
=======
  validates :description, :user_id, :question_id, presence: true
  validates :description, length: { minimum: 50 }
>>>>>>> 6e871fb4e0efaf7d37fd2daf1218c52c13e64a73
end
