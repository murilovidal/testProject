class HomeController < ApplicationController

  def index
    @articles = Article.all
    @videos = Video.all
  end
  
end
