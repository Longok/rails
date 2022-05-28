class PaymentsController < ApplicationController

    def index

    end

    def new
        @bill = Bill.find(params[:bill_id])
        @payment = @bill.payments.new
    end


    def create
        @cart = current_cart.id
        @bill = Bill.find(params[:bill_id])
        @payment = @bill.payments.new payment_params.merge(user_id: current_user.id)

        if @payment.save
            Cart.destroy(session[:cart_id])
            session[:cart_id] = nil
            flash[:info] = "Thank you for order"
            redirect_to "/products"
        else 
            render :new
        end
    end 


    private
    def payment_params
        params.require(:payment).permit :address, :phone_number, :payment_type, :user_id, :bill_id
    end
end
