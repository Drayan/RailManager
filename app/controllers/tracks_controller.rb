class TracksController < ApplicationController
    def index
        @tracks = Track.all
    end

    def show
        @track = Track.find(params[:id])
    end

    def new
        @track = Track.new
    end

    def create
        @track = Track.new(track_params)

        if @track.save
            if @track.yard
                redirect_to yard_path(@track.yard)
            else
                redirect_to tracks_path
            end
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @track = Track.find(params[:id])
    end

    def update
        @track = Track.find(params[:id])

        if @track.udpate(track_params)
            if @track.yard
                redirect_to yard_path(@track.yard)
            else
                redirect_to tracks_path
            end
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private
    def track_params
        params.require(:track).permit(:name, :length, :weigth, :yard_id)
    end
end
