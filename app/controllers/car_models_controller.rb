class CarModelsController < ApplicationController
    def new
        @car = CarType.find(params[:car_type_id])
        @model = @car.car_models.build
    end

    def create
        @car = CarType.find(params[:car_type_id])
        @model = @car.car_models.create(model_params)

        if @model.save
            redirect_to car_type_path(@car)
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @car = CarType.find(params[:car_type_id])
        @model = @car.car_models.find(params[:id])
    end

    def update
        @car = CarType.find(params[:car_type_id])
        @model = @car.car_models.find(params[:id])

        if @model.update(model_params)
            redirect_to car_type_path(@car)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @car = CarType.find(params[:car_type_id])
        @model = @car.car_models.find(params[:id])
        @model.destroy

        redirect_to car_type_path(@car)
    end

    private
    def model_params
        params.require(:car_model).permit(:FQDN)
    end
end
