class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_secure_password

  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password, length: { in: 6..20 }, on: :create

  after_destroy :user_delete_notification, prepend: true

  def full_name
    "#{firstname} #{lastname}"
  end

  def user_delete_notification
    UserMailer.deleted_user_notification(self)
  end

end
