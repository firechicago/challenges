class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :user_id, presence: true
  validates :title, length: { minimum: 50 }
  validates :description, length: { minimum: 150 }
end
