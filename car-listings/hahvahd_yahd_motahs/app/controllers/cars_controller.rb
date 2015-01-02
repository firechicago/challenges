class CarsController < ApplicationController
  def new
    @car = Car.new
    @manufacturers = [[]]
    Manufacturer.all.each do |manufacturer|
      @manufacturers << [manufacturer.name, manufacturer.id]
    end
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      flash[:notice] = "Car created"
      redirect_to cars_path
    else
      flash.now[:notice] = "Your car couldn't be saved."
      @manufacturers = [[]]
      Manufacturer.all.each do |manufacturer|
        @manufacturers << [manufacturer.name, manufacturer.id]
      end
      render :new
    end
  end

  def index
    @cars = Car.all
  end

  def show
  end

  private

  def car_params
    params.require(:car).permit(
      :manufacturer_id,
      :color,
      :year,
      :mileage,
      :description
    )
  end
end
