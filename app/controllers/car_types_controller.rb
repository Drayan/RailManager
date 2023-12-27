class CarTypesController < ApplicationController
    def index
        @cars = CarType.all
    end

    def show
        @car = CarType.find(params[:id])
    end

    def new
        @car = CarType.new
    end

    def create
        @car = CarType.new(car_params)

        if @car.save
            redirect_to @car
        else
            render :new, status: :unprocessable_entity
        end
    end

    private
    def car_params
        params.require(:car_type).permit(:name)
    end
end
