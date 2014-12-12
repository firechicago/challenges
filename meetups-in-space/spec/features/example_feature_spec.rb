RSpec::Matchers.define :order_text do |first, second|
  match do |page|
    page.text.index(first) < page.text.index(second)
  end
  failure_message do
    "\"#{first}\" does not appear before \"#{second}\""
  end
end

require 'spec_helper'

feature "User views a meetup page" do
  scenario "user sees meetup information" do
    # As a user
    # I want to view the details of a meetup
    # So that I can learn more about its purpose
    #
    # Acceptance Criteria:
    #
    # * I should see the name of the meetup.
    # * I should see a description of the meetup.
    # * I should see where the meetup is located.
    FactoryGirl.create_list(:meetup, 3)
    meetup = Meetup.first
    visit '/meetups/' + meetup.id.to_s

    expect(page).to have_content meetup.name
    expect(page).to have_content meetup.description
    expect(page).to have_content meetup.location
  end
end

feature 'User views the index page' do
  # As a user
  # I want to view a list of all available meetups
  # So that I can get together with people with similar interests
  #
  # Acceptance Criteria:
  #
  # * Meetups should be listed alphabetically.
  # * Each meetup listed should link me to the show page for that meetup.

  scenario 'user sees a list of meetups' do
    FactoryGirl.create_list(:meetup, 5)
    meetups = Meetup.all
    meetups.each do |meetup|
      visit '/'
      expect(page).to have_content(meetup.name)
      click_link(meetup.name)
      expect(current_path).to eq('/meetups/' + meetup.id.to_s)
    end
  end
end

feature 'User creates a meetup' do
  # As a user
  # I want to create a meetup
  # So that I can gather a group of people to discuss a given topic
  #
  # Acceptance Criteria:
  #
  # * I must be signed in.
  # * I must supply a name.
  # * I must supply a location.
  # * I must supply a description.
  # * I should be brought to the details page for the meetup after I create it.
  # * I should see a message that lets me know that I have created a meetup successfully.

  # let(:user) { FactoryGirl.create(:user) }
  #
  # before :each do
  #   @user = FactoryGirl.create(:user)
  #   login(@user)
  #   visit '/create'
  # end

  scenario 'user not signed in' do
    visit '/create'
    expect(page).to have_content('You need to sign in if you want to do that!')
  end

  scenario 'user correctly creates meetup' do
    mock_sign_in
    visit '/create'
    expect(page).to have_content('Create a new meetup')
    fill_in 
  end

  scenario 'user does not supply name'
  scenario 'user does not supply location'
  scenario 'user does not supply description'
end

feature 'Join a meetup' do
  # As a user
  # I want to join a meetup
  # So that I can talk to other members of the meetup
  #
  # Acceptance Criteria:
  #
  # * I must be signed in.
  # * From a meetups detail page, I should click a button to join the meetup.
  # * I should see a message that tells let's me know when I have successfully joined a meetup.
end

feature 'View members' do
  # As a user
  # I want to see who has already joined a meetup
  # So that I can see if any of my friends have joined
  #
  # Acceptance Criteria:
  #
  # * On the details page for a meetup, I should see a list of the members that have already joined.
  # * I should see each member's avatar.
  # * I should see each member's username.
  scenario 'when viewing a meetup page' do
    meetup = FactoryGirl.create(:meetup)
    users = FactoryGirl.create_list(:user, 5)
    users.each do |user|
      Membership.create(user_id: user.id, meetup_id: meetup.id)
    end
    visit '/meetups/' + meetup.id.to_s
    meetup.users.each do |user|
      expect(page).to have_content(user.username)
      expect(page).to have_xpath("//img[contains(@src,\"#{user.avatar_url}\")]")
    end
  end
end

feature 'Leave a meetup' do
  # As a user
  # I want to leave a meetup
  # So that I'm no longer listed as a member of the meetup
  #
  # Acceptance Criteria:
  #
  # * I must be authenticated.
  # * I must have already joined the meetup.
  # * I see a message that lets me know I left the meetup successfully.
end

feature "user signs in" do
  scenario "try setting session value" do
    login = mock_sign_in
    expect(page).to have_content("Signed in as #{login.username}")
  end
end

feature 'Comment on a meetup' do
  # As a user
  # I want to leave comments on a meetup
  # So that I can communicate with other members of the group
  #
  # Acceptance Criteria:
  #
  # * I must be authenticated.
  # * I must have already joined the meetup.
  # * I can optionally provide a title for my comment.
  # * I must provide the body of my comment.
  # * I should see my comment listed on the meetup show page.
  # * Comments should be listed most recent first.
end

def mock_sign_in
  user = FactoryGirl.create(:user)

  OmniAuth.config.mock_auth[:github] = {
    "provider" => "github",
    "uid" => user.uid,
    "info" => {
      "nickname" => user.username,
      "email" => user.email,
      "image" => user.avatar_url
    },
    "credentials" => {
      "token" => "12345"
    }
  }

  visit "/"
  click_link "Sign in"
  user
end
