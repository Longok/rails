class ProductsController < ApplicationController
    before_action :logged_in_user, only: [:new, :destroy]

    def index
        @products = Product.all
    end

    def show
        @product = Product.find_by id: params[:id]
    end

    def new
        @product = Product.new
        @user = User.new

    end

    def create
        @product = Product.new product_params  
        if @product.save
            flash.now[:success] = "Create product successfully"
            redirect_to products_path
        else
            render :new
        end
    end

    def destroy
        @product = Product.find_by id: params[:id]
        if @product.destroy
            flash.now[:success] = "Delete product successfully"
        else
            
        end
        redirect_to products_path
    end

    private 
    def product_params
        params.require(:product).permit(:name, :price, :image)
    end

  
end
