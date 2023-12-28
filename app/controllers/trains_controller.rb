class TrainsController < ApplicationController
    def index
        @trains = Train.all
    end

    def show
        @train = Train.find(params[:id])
    end

    def new
        @train = Train.new
        @yard = Yard.new
    end

    def create
        if params[:commit] == nil
            @train = Train.new(train_params.except(:yard_id))
            @yard = Yard.find(params[:train][:yard_id])

            render :new, status: :unprocessable_entity # Not really unprocessable, but it's needed for turbo to rerender
        else
            @train = Train.new(train_params.except(:yard_id))
            if @train.save
                redirect_to trains_path
            else
                render :new, status: :unprocessable_entity
            end
        end
    end

    def destroy
        @train = Train.find(params[:id])
        @train.destroy

        redirect_to trains_path
    end

    private
    def train_params
        params.require(:train).permit(:routing_tag, :length, :weigth, :yard_id, :track_id)
    end
end
