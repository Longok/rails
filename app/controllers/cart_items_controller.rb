class CartItemsController < ApplicationController

    def create
<<<<<<< HEAD:app/controllers/bills_controller.rb
        @cart = Cart.find(session[:cart_id])
        product = Product.find_by (params[:product_id])
        @bill = @cart.add_product(product.id)
=======
        @cart = current_cart
        product = Product.find(params[:product_id])
        @cart_item = @cart.add_product(product)
>>>>>>> cart-item:app/controllers/cart_items_controller.rb

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
