class Admin::UsersController < ApplicationController

  before_filter :restrict_access
  before_filter :admin?

  def index

  end
end
