class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: [:destroy]

    def show
        @micropost = Micropost.find_by id: params[:id]
    end

    def create
        @micropost = current_user.microposts.build microposts_params
        # @micropost.images.attach(params[:micropost][:images])
        if @micropost.save
            flash[:success] = "Micropost created"
            redirect_to root_url
        else
            @feed_items = current_user.feed.page(params[:page])
            render "static_pages/home"
        end
    end


    def destroy
        if @micropost.destroy
            flash[:success] = "Micropost deleted"
        else
            flash[:danger] = "Deleted fail"
        end
        redirect_to request.referer || root_url
    end

  

    private
    def microposts_params
        params.require(:micropost).permit(:content, images: []) 
    end

    def correct_user
        @micropost = current_user.microposts.find_by id: params[:id]
        return if @micropost
        flash[:danger] = "Micropost invalid"
        redirect_to request.referrer || root_url
    end
end
