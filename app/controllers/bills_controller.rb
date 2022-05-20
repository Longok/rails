class BillsController < ApplicationController
   
    def create
        @cart = current_cart
        product = Product.find(params[:product_id])
        @bill = @cart.add_product(product)

        @bill.save
        flash[:info] = "Them vao gio hang thanh cong"
        redirect_to cart_path(@cart)

    end

    def destroy
        @bill = Bill.find(params[:id])
        @bill.destroy
        flash[:info] = "Xoa san pham thanh cong"
        redirect_to cart_path(@cart)
    end


    def add_quantity
        @cart = current_cart
        @bill = Bill.find(params[:id])
        @bill.quantity += 1
        @bill.save
        flash[:info] = "Cap nhat san pham thanh cong"
        redirect_to cart_path(@cart)
    end

    def reduce_quantity
        @cart = current_cart
        @bill = Bill.find(params[:id])
        if @bill.quantity > 1
            @bill.quantity -= 1
            flash[:info] = "Cap nhat san pham thanh cong"
        else         
            @bill.quantity = 0 
            @bill.destroy
            flash[:info] = "Xoa san pham thanh cong"
            
        end
        @bill.save
        redirect_to cart_path(@cart)
    end

    private
    def bill_params
        params.require(:bill).permit(:quantity, :product_id, :cart_id)
    end
end
