class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception 
    before_action :current_cart
    before_action :current_cart_noti

    include SessionsHelper

    private
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end

    def current_cart
        Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
        cart = Cart.create
        session[:cart_id] = cart.id
        cart
    end

    def current_cart_noti
        @cart = current_cart
    end

end
