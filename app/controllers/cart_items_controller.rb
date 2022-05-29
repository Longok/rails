class CartItemsController < ApplicationController

    def create
        @cart = current_cart
        product = Product.find(params[:product_id])
        @cart_item = @cart.add_product(product)

        @cart_item.save
        flash[:info] = "Them vao gio hang thanh cong"
        redirect_to cart_path

    end

    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        flash[:info] = "Xoa san pham thanh cong"
        redirect_to cart_path
    end


    def add_quantity
        @cart = current_cart
        @cart_item = CartItem.find(params[:id])
        @cart_item.quantity += 1
        @cart_item.save
        flash[:info] = "Cap nhat san pham thanh cong"
        redirect_to cart_path(@cart)
    end

    def reduce_quantity
        @cart = current_cart
        @cart_item = CartItem.find(params[:id])
        if @cart_item.quantity > 1
            @cart_item.quantity -= 1
            flash[:info] = "Cap nhat san pham thanh cong"
        else         
            @cart_item.quantity = 0 
            @cart_item.destroy
            flash[:info] = "Xoa san pham thanh cong"
            
        end
        @cart_item.save
        redirect_to cart_path(@cart)
    end

    private
    def cart_item_params
        params.require(:cart_item).permit(:quantity, :product_id, :cart_id)
    end
end
