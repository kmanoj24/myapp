class ActorsController < ApplicationController
  before_action :set_actor, only: [:show, :update, :destroy]

  # GET /actors
  def index
    byebug
    @actors = Actor.all
    render json: @actors
  end

  # GET /actors/:id
  def show
    render json: @actor
  end

  # POST /actors
  def create
    @actor = Actor.new(actor_params)
    if @actor.save
      render json: @actor, status: :created
    else
      render json: @actor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /actors/:id
  def update
    if @actor.update(actor_params)
      render json: @actor
    else
      render json: @actor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /actors/:id
  def destroy
    @actor.destroy
    head :no_content
  end

  private

  def set_actor
    @actor = Actor.find(params[:id])
  end

  def actor_params
    params.require(:actor).permit(:first_name, :last_name)
  end
end
