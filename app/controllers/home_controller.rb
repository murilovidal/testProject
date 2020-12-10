class HomeController < ApplicationController
  
  def index
    @articles = Article.all
    @videos = Video.all
  end
  
  def admin_index
    @users = User.all
  end
end
