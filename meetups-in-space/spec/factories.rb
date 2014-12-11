FactoryGirl.define do
  factory :user do
    provider 'Github'
    sequence(:uid) {|n| "awefuiohsodhf#{n}" }
    username 'tester'
    email 'test@test.com'
    avatar_url 'http://test.com/avatar.jpg'
  end
end
