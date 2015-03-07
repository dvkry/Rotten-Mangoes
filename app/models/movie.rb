class Movie < ActiveRecord::Base
  has_many :reviews
  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
#  validates :poster_image_url, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_future

  mount_uploader :image, ImageUploader

  scope :title_or_director, -> (title_or_director) { where("title like ? OR director like ?", "%#{title_or_director}%", "%#{title_or_director}%") }
  scope :runtime, -> (min, max) { where("runtime_in_minutes BETWEEN ? AND ?", min, max )}

  def review_average
    reviews.size > 0 ? reviews.sum(:rating_out_of_ten)/reviews.size : 0
  end

  protected

  def release_date_is_in_the_future
    errors.add(:release_date, "should probably be in the future") if release_date.present? && release_date < Date.today
  end

end
