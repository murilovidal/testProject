class ArticlesController < ApplicationController
    
    def index
        @articles = Article.all
    end

    def new
        unless authorized?
            @article = Article.new
        end
    end

end
