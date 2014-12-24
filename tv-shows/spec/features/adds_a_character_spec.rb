require 'rails_helper'

feature 'user adds a new character', %Q{
  As a site visitor
  I want to add my favorite TV show characters
  So that other people can enjoy their crazy antics
  } do

    # Acceptance Criteria:
    # * I can access a form to add a character on a TV show's page
    # * I must specify the character's name and the actor's name
    # * I can optionally provide a description
    # * If I do not provide the required information, I receive an error message
    # * If the character already exists in the database, I receive an error message

    scenario 'user adds a new character' do
      attrs = {
        character_name: 'Ned Stark',
        actor_name: 'Sean Bean',
        description: 'Lord of the North'
      }
      show = TelevisionShow.create(title: 'Game of Thrones',
      network: 'HBO' )
      char = Character.new(attrs)

      visit "/television_shows/#{show.id}/characters/new"
      fill_in 'Character Name', with: char.character_name
      fill_in 'Actor Name', with: char.actor_name
      fill_in 'Description', with: char.description
      click_on 'Submit'

      expect(page).to have_content 'Success'
      expect(page).to have_content char.character_name
      expect(page).to have_content char.actor_name
      expect(page).to have_content char.description
    end

    scenario 'without required attributes' do
      show = TelevisionShow.create(title: 'Game of Thrones',
      network: 'HBO' )
      visit "/television_shows/#{show.id}/characters/new"
      click_on 'Submit'

      expect(page).to_not have_content 'Success'
      expect(page).to have_content "can't be blank"
    end

    scenario 'user cannot add a character that is already in the database' do
      attrs = {
        character_name: 'Ned Stark',
        actor_name: 'Sean Bean'
      }
      show = TelevisionShow.create(title: 'Game of Thrones',
      network: 'HBO' )
      char = Character.new(attrs)

      visit "/television_shows/#{show.id}/characters/new"
      fill_in 'Character Name', with: char.character_name
      fill_in 'Actor Name', with: char.actor_name

      expect(page).to_not have_content 'Success'
    end
  end
