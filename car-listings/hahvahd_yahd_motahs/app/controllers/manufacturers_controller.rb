class ManufacturersController < ApplicationController
  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if @manufacturer.save
      flash[:notice] = "Manufacturer #{@manufacturer.name} created"
      redirect_to manufacturers_path
    else
      flash.now[:notice] = "Your manufacturer couldn't be saved."
      render :new
    end
  end

  def index
    @manufacturers = Manufacturer.all
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name, :country)
  end
end
