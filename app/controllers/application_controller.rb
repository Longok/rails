class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception 
    before_action :current_cart
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
        if session[:cart_id]
            cart = Cart.find_by(:id => session[:cart_id])
            if cart.present?
                @current_cart = cart
            else
                session[:cart_id] = nil
            end
        end

        if session[:cart_id] == nil
            @current_cart = Cart.create
            session[:cart_id] = @current_cart.id
        end
    end
end
