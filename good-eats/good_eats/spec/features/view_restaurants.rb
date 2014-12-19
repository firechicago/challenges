require '../spec_helper'

feature 'User views the index page' do
  scenario 'User opens /restaurants' do
    visit '/restaurants'

    expect(page).to have_content(Restaurant.first.name)
    expect(page).to have_content(Restaurant.last.name)
  end
end
