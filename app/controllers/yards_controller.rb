class YardsController < ApplicationController
    def index
        @yards = Yard.all
    end

    def show
        @yard = Yard.find(params[:id])
    end

    def new
        @yard = Yard.new
    end

    def create
        @yard = Yard.new(yard_params)

        if @yard.save
            redirect_to yards_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    private
    def yard_params
        params.require(:yard).permit(:name, :routing_tag)
    end
end
