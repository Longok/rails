class PaymentsController < ApplicationController

    def index

    end

    def new
        @payment = Payment.new
    end


    def create
        @payment = Payment.new payment_params
        @user = current_user
        @bill = Bill.find_by id: params[:id]

        if @payment.save
            Cart.destroy(session[:cart_id])
            session[:cart_id] = nil
            flash[:info] = "Thank you for order"
            redirect_to "/payments"
        else 
            render :new
        end
    end 


    private
    def payment_params
        params.require(:payment).permit :address, :phone_number, :payment_type, :user_id, :bill_id
    end
end
