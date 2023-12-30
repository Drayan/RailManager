class SupplyTrainBlueprintsController < ApplicationController
  def index
    @trains = SupplyTrainBlueprint.all
  end

  def new
    @bp = SupplyTrainBlueprint.new
  end

  def create
    @bp = SupplyTrainBlueprint.new(train_params)

    if @bp.save
      redirect_to supply_train_blueprints_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def train_params
    params.require(:supply_train_blueprint).permit(:routing_tag, :destination, :avg_cars, :max_weight, :max_length, :spawn_point_id)
  end
end
