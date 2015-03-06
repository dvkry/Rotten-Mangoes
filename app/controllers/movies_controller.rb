class MoviesController < ApplicationController


  def index
    if params[:runtime_in_minutes]

      runtime_min = params[:runtime_in_minutes].split('_').first
      runtime_max = params[:runtime_in_minutes].split('_').last

      if params[:title_or_director] != ''
      # @movies = Movie.where("title like ? and director like ? and runtime_in_minutes between ? and ?", "%#{params[:title]}%", "%#{params[:director]}%", runtime_min, runtime_max)
        @movies = Movie.title_or_director(params[:title_or_director]).runtime(runtime_min, runtime_max)
      else
        @movies = Movie.runtime(runtime_min, runtime_max)
      end

    else
      @movies = Movie.all
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
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
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
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
