class Car < ActiveRecord::Base
  belongs_to :manufacturer

  validates :manufacturer_id, presence: true
  validates :color, presence: true
  validates :year,
    presence: true, numericality: {only_integer: true, greater_than: 1919}
  validates :mileage, presence: true, numericality: true
end
