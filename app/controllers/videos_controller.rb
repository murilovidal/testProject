class VideosController < ApplicationController
  before_action :set_video, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: %i[destroy edit update destroy_comment]

  def index
    @videos = Video.all
  end

  def show; end

  def new
    @video = Video.new
  end

  def edit; end

  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Vídeo criado com sucesso.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Vídeo atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Vídeo removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  def save_comment
    @user = current_user
    @comment = @user.comment_videos.create(body: params["comment_text_#{params[:id]}".to_sym], video_id: params[:id])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @video, notice: 'Comentário criado com sucesso.' }
        format.js
      else
        format.html { render action: 'new' }
        format.js
      end
    end
  end

  def destroy_comment
    @comment = CommentVideo.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js {}
    end
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :url)
  end
end
