class CarsController < ApplicationController
  layout "application"
  
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
  end
end
