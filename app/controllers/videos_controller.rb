class VideosController < ApplicationController

    def index
        @videos = Video.all 
    end

    def new
        unless authorized?()
            @video = Video.new
            @tags = Tag.all
        end
    end

    def create
        unless authorized?()
            @video = Video.new()
            
            @video.title = video_params[:title]
            @video.url = video_params[:url]
            @video.description = video_params[:description]

            @tags = video_params[:tag]
            @tags = @tags.gsub(/\s+/m, ' ').strip.split(" ")
            
            @tags.each do |tag|
                if Tag.find_by(tag: tag)
                    @tag = Tag.find_by(tag: tag)
                    @video.tags << @tag
                else
                    @video.tags.build(tag: tag)  
                end
            end

            if @video.save
                redirect_to '/videos'
            else
                render 'new'
            end
        end
    end
    
    def destroy
        unless authorized?()
            video = Video.find(params[:id])
            video.delete
            redirect_to videos_path
        end

    end

    
    def comment
        @video= Video.find(params[:id])
    end
    
    def save_comment
        @video = Video.find(params[:id])
        @user = current_user
        @comment = Comment.new(comment: params[:comment])
        @user.comments << @comment
        @video.comments << @comment
        redirect_to videos_path      
    end
    

    
    private
    def video_params
        params.require(:video).permit(:title, :description, :url, :tag)
    end
end
