class PaymentsController < ApplicationController

    def index

    end

    def new
        @payment = Payment.new
    end


    def create
        @bills = Bill.find(params[:bill_id])
        @payment = @bill.payments.new payment_params.merge(user_id: current_user.id) #=> payment

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
        params.require(:payment).permit :address, :phone_number, :payment_type, :user_id, :bill_id =#{ address: 'asdas', phone_number: '123123' } => #{ address: 'asdas', phone_number: '123123', user_id: 10 }
    end
end


GET        bills/:bill_id/payments => inde
GET        bills/:bill_id/payments/new => new
POST       bills/:bill_id/payments => create
GET        bills/:bill_id/payments/:id => show
GET        bills/:bill_id/payments/:id/edit => edit
PUT/Patch  bills/:bill_id/payments/:id/update => update
PUT/Patch  bills/:bill_id/payments/:id/destroy => destroy

body:
params  payment => {  address=> '12321' }