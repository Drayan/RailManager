class SpawnPointsController < ApplicationController
  def index
    @points = SpawnPoint.all
  end

  def new
    @point = SpawnPoint.new
  end

  def create
    @point = SpawnPoint.new(point_params)

    if @point.save
      redirect_to spawn_points_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def point_params
    params.require(:spawn_point).permit(:allow_supply_train, :track_id)
  end
end
