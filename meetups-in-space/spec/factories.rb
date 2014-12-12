require 'pry'

def random_string(n)
  string = ''
  n.times { string += (65 + rand(26)).chr }
  string
end

FactoryGirl.define do
  factory :user do
    provider 'Github'
    sequence(:uid) { |n| "awefuiohsodhf#{n}" }
    username 'tester'
    email 'test@test.com'
    avatar_url 'http://test.com/avatar.jpg'
  end

  factory :meetup do
    sequence(:name) {random_string(5)}
    sequence(:location) {random_string(5)}
    sequence(:description) {random_string(50)}
  end
end
