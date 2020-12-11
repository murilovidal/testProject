class ArticlesController < ApplicationController
    
    def index
        @articles = Article.all
    end

    def new
        unless authorized?
            @article = Article.new
            @tags = Tag.all
        end
    end

    def create
        @article = Article.new()
        
        @article.title = article_params[:title]
        @article.body = article_params[:body]

        @tags = article_params[:tag]
        @tags = @tags.gsub(/\s+/m, ' ').strip.split(" ")
        
        @tags.each do |tag|
            if Tag.find_by(tag: tag)
                @tag = Tag.find_by(tag: tag)
                @article.tags << @tag
            else
                @article.tags.build(tag: tag)  
            end
        end

        if @article.save
            redirect_to '/article'
        else
            render 'new'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.delete  
        redirect_to articles_path      
    end
    
    private
    def article_params
        params.require(:article).permit(:title, :body, :tag)
    end
    
    
end
