class Review < ActiveRecord::Base
  belongs_to :restaurant

  validates_presence_of :review_text
  validates_presence_of :restaurant_id
end
