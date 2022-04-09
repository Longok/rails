class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update]

    def index
        @users = User.paginate(page:params[:page])
       
    end

    def show
        @user = User.find_by id: params[:id]
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            log_in @user
            flash[:success] = "User was successfuly create!"
            redirect_to @user
        else
            render :new
        end       
    end


    def edit
        @user = User.find_by id: params[:id]
    end

    def update
        @user = User.find_by id: params[:id]
        if @user.update(user_params)
            flash[:success] = "User was successfully updated!"
            redirect_to @user
        else
            render :edit, notice: "Update fail"
        end
    end


    def destroy
        @user = User.find_by(id: params[:id])
        if @user&.destroy
            flash[:success] = "User deleted"
        else
            flash[:danger] = "Delete fail!"
        end
        redirect_to users_url
    end

    # Before filters
    # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end

    # Confirms the correct user.
    def correct_user
        @user = User.find_by id: params[:id]
        redirect_to(login_url) unless @user == current_user
    end

    private
    def user_params
        params.require(:user).permit :name, :email, :password, :password_confirmation
    end
end
