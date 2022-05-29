class PaymentsController < ApplicationController

    def index

    end

    def new
        @payment = Payment.new
    end


    def create
        @payment = @cart.payments.build payment_params
        @payment.user_id = current_user.id

        if @payment.save
            @cart = Cart.find(session[:cart_id])
            session[:cart_id] = nil
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
