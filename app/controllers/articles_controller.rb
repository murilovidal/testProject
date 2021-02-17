class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: %i[destroy edit update destroy_comment]

  def index
    @articles = Article.all
  end

  def show; end

  def new
    redirect_to articles_path unless current_user.admin

    @article = Article.new
  end

  def edit
    redirect_to articles_path unless current_user.admin
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Artigo criado com sucesso.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if current_user.admin
      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to @article, notice: 'Artigo atualizado com sucesso.' }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to articles_path
    end
  end

  def destroy
    if current_user.admin
      @article.destroy
      respond_to do |format|
        format.html { redirect_to articles_url, notice: 'Artigo removido com sucesso.' }
        format.json { head :no_content }
      end
    else
      redirect_to articles_path
    end
  end

  def save_comment
    @user = current_user
    @comment = @user.comment_articles.create(body: params["comment_text_#{params[:id]}".to_sym], article_id: params[:id])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @article, notice: 'Comentário criado com sucesso.' }
        format.js
      else
        format.html { render action: 'new' }
        format.js
      end
    end
  end

  def destroy_comment
    @comment = CommentArticle.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js {}
    end
  end

  def show_comment
    @comment = CommentArticle.find(params[:id])
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
