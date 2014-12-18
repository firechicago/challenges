class User < ActiveRecord::Base
  has_many :questions
  has_many :answers

  validates :name, presence: true

  def self.find_or_create_from_omniauth(auth)
    account_keys = { uid: auth["uid"], provider: auth["provider"] }
    user = User.find_or_initialize_by(account_keys)
    user.name = "chris"
    user.save!
    user
  end
end
