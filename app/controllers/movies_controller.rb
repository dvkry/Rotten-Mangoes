class MoviesController < ApplicationController

  before_filter :load_movie, only: [:show, :edit, :update, :destroy]

  def index
    if params[:title] || params[:director] || params[:runtime_in_minutes]
      runtime_min = 0
      runtime_max = 480
      case params[:runtime_in_minutes]
      when 'any'
        runtime_min = 0
        runtime_max = 480
      when 'under 90'
        runtime_max = 90
      when '90 - 120'
        runtime_min = 90
        runtime_max = 120
      when 'over 120'
        runtime_min = 120
        runtime_max = 480
      end

      @movies = Movie.where("title like ? and director like ? and runtime_in_minutes between ? and ?", "%#{params[:title]}%", "%#{params[:director]}%", runtime_min, runtime_max)
    else
      @movies = Movie.all
    end
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image, :remote_image_url
      )
  end

end
