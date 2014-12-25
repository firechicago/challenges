require 'rails_helper'

feature 'user deletes a character', %Q{
  As a site visitor
  I want to delete a character I don't like
  So no one else will want to watch that character
  } do

    # Acceptance Criteria:
    # * I can delete a character from the database
    # * If the record is successfully deleted, I receive an notice that it was deleted

    scenario 'user deletes a character' do
      show = TelevisionShow.create(title: 'Game of Thrones',
      network: 'HBO' )
      attrs = {
        character_name: 'Ned Stark',
        actor_name: 'Sean Bean',
        description: 'Lord of the North',
        television_show_id: show.id
      }
      char = Character.create(attrs)

      visit "/television_shows/#{show.id}/characters/#{char.id}/edit"
      click_link('delete this character')

      expect(page).to have_content 'Character deleted'
      expect(page).to_not have_content char.character_name
      expect(page).to_not have_content char.actor_name
      expect(page).to_not have_content char.description
    end
  end
