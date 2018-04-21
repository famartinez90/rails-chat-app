class HomeController < ApplicationController
  def index
  end

  def home
    unless session[:user]
      session[:user] = params['user']
    end

    @groups = Group.all()
  end
end
