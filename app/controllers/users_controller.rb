class UsersController < ApplicationController

    def index
        @users = User.all.order('id DESC')
       
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
            redirect_to new_user_path, notice: "User was successfuly create"
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
            redirect_to @user, notice: "User was successfully updated."
        else
            render :edit, notice: "Update fail"
        end
    end


    def destroy
        @user = User.find_by id: params[:id]
        @user.destroy
        redirect_to root_path
    end

    private
    def user_params
        params.require(:user).permit :name, :email, :password, :password_confirmation
    end
end
