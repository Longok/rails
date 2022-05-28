class PaymentsController < ApplicationController

    def index

    end

    def new
        @cart = current_cart.id
        @payment = Payment.new
    end


    def create
        @payment = @cart.payments.build payment_params
        @payment.user_id = current_user.id

        if @payment.save         
            @cart = current_cart.id
            @cart.nil?
            flash[:info] = "Thank you for order"
            redirect_to "/products"
            if @cart == nil 
                session[:cart_id] = nil
            else
            end
        else 
            render :new
        end
    end 


    private
    def payment_params
        params.require(:payment).permit :address, :phone_number, :payment_type, :cart_id, :user_id
    end


end
