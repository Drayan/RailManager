class LocalTrainsController < ApplicationController
  def index
    @locals = LocalTrain.all
  end

  def new
    @local = LocalTrain.new
  end

  def create
    @local = LocalTrain.new(local_train_params)

    if @local.save
      redirect_to local_trains_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def local_train_params
    params.require(:local_train).permit(:name, :routing_tag, :yard_id)
  end
end
