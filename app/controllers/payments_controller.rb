class PaymentsController < ApplicationController

    def new
        @payment = Payment.new
    end


    def create
      
    end 


    private
    def payment_params
        params.require(:payment).permit :address, :phone_number, :type, :user_id, :bill_id
    end
end
