class CartsController < ApplicationController

  def show
    @cart = current_cart
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to cart_path
  end

end
