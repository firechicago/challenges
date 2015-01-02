require 'rails_helper'

feature 'salesperson adds a new manufacturer', %Q{
  As a car salesperson
  I want to record a car manufacturer
  So that I can keep track of the types of cars found in the lot
  } do

    # Acceptance Criteria:

    # * I must specify a manufacturer name and country.
    # * If I do not specify the required information, I am presented
    #     with errors.
    # * If I specify the required information, the manufacturer is
    #   recorded and I am redirected to the index of manufacturers
    #
    before(:each) do
      @manufacturer = Manufacturer.new(name: 'Fiat', country: 'Italy')
    end

    scenario 'salesperson specifies name and country' do
      visit new_manufacturer_path
      fill_in 'Name', with: @manufacturer.name
      fill_in 'Country', with: @manufacturer.country
      click_on 'Submit'

      expect(page).to have_content "Manufacturer #{@manufacturer.name} created"
      expect(page).to have_content "List of manufacturers"
    end

    scenario 'salesperson fails to specify name' do
      visit new_manufacturer_path
      fill_in 'Country', with: @manufacturer.country
      click_on 'Submit'

      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Add a manufacturer"
    end

    scenario 'salesperson fails to specfy country' do
      visit new_manufacturer_path
      fill_in 'Name', with: @manufacturer.name
      click_on 'Submit'

      expect(page).to have_content "Country can't be blank"
      expect(page).to have_content "Add a manufacturer"
    end
  end
