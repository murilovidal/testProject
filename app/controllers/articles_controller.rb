class ArticlesController < ApplicationController
    
    def index
        if params[:query]
            @articles = Article.search(params[:query])
            if @articles == nil
                @articles = Article.all
                flash.alert =  "Nada encontrado. Mostrando todas as notícias"
            end
        else
            @articles = Article.all
        end
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        unless authorized?()
            @article = Article.new
            @tags = Tag.all
        end
    end

    def create
        unless authorized?()
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
    end 

    def destroy
        unless authorized?()
            @article = Article.find(params[:id])
            @article.delete  
            redirect_to articles_path
        end
    end

    def comment
        @article = Article.find(params[:id])
    end

    def save_comment
        @article = Article.find(params[:id])
        @comment = Comment.new(comment: params[:comment])
        @comment.save
        @article.comments << @comment
        redirect_to articles_path      
    end
    
    def search
        @articles = Article.search(params[:query])
    end


    private
    def article_params
        params.require(:article).permit(:title, :body, :tag, :comment, :query)
    end
       
end
