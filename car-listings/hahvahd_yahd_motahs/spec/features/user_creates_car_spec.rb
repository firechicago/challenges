require 'rails_helper'

feature 'salesperson adds a new car', %Q{
  As a car salesperson
  I want to record a newly acquired car
  So that I can list it in my lot
  } do

    # Acceptance Criteria:
    #
    # * I must specify the manufacturer, color, year, and mileage of the
    #   car (an association between the car and an existing manufacturer should be created).
    # * Only years from 1920 and above can be specified.
    # * I can optionally specify a description of the car.
    # * If I enter all of the required information in the required
    #   formats, the car is recorded and I am presented with a notification of success.
    # * If I do not specify all of the required information in the
    #   required formats, the car is not recorded and I am presented with errors.
    # * Upon successfully creating a car, I am redirected back to the
    #   index of cars.
    before(:each) do
      manufacturer = Manufacturer.create(name: 'Ford', country: 'USA')
      @car = Car.new(
        manufacturer_id: manufacturer.id,
        color: 'Crystal Blue',
        year: 1994,
        mileage: 100_000,
        description: 'rockin ride'
        )
    end

    scenario 'salesperson fills out all required data' do
      visit new_car_path
      select @car.manufacturer.name, from: 'car[manufacturer_id]'
      fill_in 'Color', with: @car.color
      fill_in 'Year', with: @car.year
      fill_in 'Mileage', with: @car.mileage
      fill_in 'Description', with: @car.description
      click_on 'Submit'

      expect(page).to have_content "Car created"
      expect(page).to have_content "List of cars"
    end

    scenario 'salesperson enters invalid year' do
      visit new_car_path
      select @car.manufacturer.name, from: 'car[manufacturer_id]'
      fill_in 'Color', with: @car.color
      fill_in 'Year', with: 1900
      fill_in 'Mileage', with: @car.mileage
      click_on 'Submit'

      expect(page).to have_content "Year must be greater than 1919"
      expect(page).to have_content "Add a car"
    end

    scenario 'salesperson fails to specify required data' do
      visit new_car_path
      click_on 'Submit'

      expect(page).to have_content "Manufacturer can't be blank"
      expect(page).to have_content "Color can't be blank"
      expect(page).to have_content "Year can't be blank"
      expect(page).to have_content "Mileage can't be blank"
      expect(page).to have_content "Add a car"
    end
  end
