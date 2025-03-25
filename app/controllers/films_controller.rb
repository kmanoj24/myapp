class FilmsController < ApplicationController
  before_action :set_film, only: [:show, :update, :destroy]

  # GET /films
  def index
    @films = Film.all
    render json: @films
  end

  # GET /films/:id
  def show
    render json: @film
  end

  # POST /films
  def create
    @film = Film.new(film_params)
    if @film.save
      render json: @film, status: :created
    else
      render json: @film.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /films/:id
  def update
    if @film.update(film_params)
      render json: @film
    else
      render json: @film.errors, status: :unprocessable_entity
    end
  end

  # DELETE /films/:id
  def destroy
    @film.destroy
    head :no_content
  end

  private

  def set_film
    @film = Film.find(params[:id])
  end

  def film_params
    params.require(:film).permit(:title, :description, :release_year, :language_id, :rental_duration, :rental_rate, :length, :replacement_cost, :rating)
  end
end
