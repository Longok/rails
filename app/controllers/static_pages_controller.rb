class StaticPagesController < ApplicationController
  def home
    # @micropost = current_user.microposts.build if logged_in? 
    @cart = current_cart

    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.order("id DESC").paginate(page: params[:page], per_page: 10)
    end

  end

  def help
    @cart = current_cart

  end
end
