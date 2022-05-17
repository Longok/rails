class BillsController < ApplicationController

    def create
        chose_product = Product.find(params[:product_id])
        current_cart = @current_cart

        if current_cart.products.include?(chose_product)
           @bill = current_cart.bills.find_by(:product_id => chose_product)
           @bill.quantity += 1

        else
            @bill = Bill.new
            @bill.cart = current_cart
            @bill.product = chose_product
        end
        @bill.save
        redirect_to cart_path
    end
    
    def destroy
        @bill = Bill.find(params[:id])
        @bill.destroy

        redirect_to cart_path
    end

    private
    def bill_params
        params.require(:bill).permit(:quantity, :product_id, :cart_id)
    end
end
