require 'rails_helper'

feature "user views a TV show's details", %Q{
  As a site visitor
  I want to view the details for a TV show
  So I can find learn more about it
  I can see a the show's title, network, the years it ran, and a synopsis.
} do

  # Acceptance Criteria:
  # * I can see a the show's title, network, the years it ran,
  # and a synopsis.

  scenario "user views a TV show's details" do
    show = TelevisionShow.create(title: 'Game of Thrones',
      network: 'HBO' )
    char = Character.create(character_name: 'Ned Stark', actor_name: 'Sean Bean',
      description: 'Lord of the North', television_show_id: show.id)
    char2 = Character.create(character_name: 'Hodor', actor_name: 'Hodor!',
    description: 'Hodor Hodor Hodor', television_show_id: show.id)

    visit "/television_shows/#{show.id}"

    expect(page).to have_content show.title
    expect(page).to have_content show.network
    expect(page).to have_content show.years
    expect(page).to have_content show.synopsis
    expect(page).to have_content char.character_name
    expect(page).to have_content char.actor_name
    expect(page).to have_content char.description
    expect(page).to have_content char2.character_name
    expect(page).to have_content char2.actor_name
    expect(page).to have_content char2.description
  end
end
