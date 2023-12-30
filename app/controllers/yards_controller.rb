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

        if @yard.classification_yard?
            @yard.yard_id = nil
        end

        if @yard.save
            redirect_to yards_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @yard = Yard.find(params[:id])
    end

    def update
        @yard = Yard.find(params[:id])

        if @yard.classification_yard?
            @yard.yard_id = nil
        end

        if @yard.update(yard_params)
            redirect_to yards_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private
    def yard_params
        params.require(:yard).permit(:name, :routing_tag, :yard_type, :yard_id)
    end
end
