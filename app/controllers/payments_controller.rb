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
            Cart.destroy(session[:cart_id])
            flash[:info] = "Thank you for order"
            redirect_to "/products"
        
        else 
            render :new
        end
    end 


    private
    def payment_params
        params.require(:payment).permit :address, :phone_number, :payment_type, :cart_id, :user_id
    end


end
