class VideosController < ApplicationController
    before_action :authorized?
    def index
            @video = Video.all 
    end

end
