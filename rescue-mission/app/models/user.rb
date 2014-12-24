class User < ActiveRecord::Base
<<<<<<< HEAD
  has_many :questions
  has_many :answers

  validates :name, presence: true

  def self.find_or_create_from_omniauth(auth)
    account_keys = { uid: auth["uid"], provider: auth["provider"] }
    user = User.find_or_initialize_by(account_keys)
    user.name = "chris"
    user.save!
    user
=======
  def self.create_with_omniauth(auth)
    create! do |user|
      puts "DEBUG " + "=" * 50
      # p auth
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
>>>>>>> 6e871fb4e0efaf7d37fd2daf1218c52c13e64a73
  end
end
