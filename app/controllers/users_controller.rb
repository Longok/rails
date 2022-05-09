class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
    before_action :correct_user, only: [:edit, :update]

    def index
        @users = User.paginate(page: params[:page],  per_page: 10)
        # render json: @users, include: [:followers, :following, :microposts]  #render json
    end

    def show
        @user = User.find_by id: params[:id]
        @micropost = current_user.microposts.build  #link bai viet
        @microposts = @user.microposts.order("id DESC").paginate(page: params[:page],  per_page: 10)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            @user.send_activation_email
            flash[:info] = "Please check your email to activate your account."
            redirect_to root_url
      
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


    # Confirms the correct user.
    def correct_user
        @user = User.find_by id: params[:id]
        redirect_to(login_url) unless @user == current_user
    end

    # Follow

    def following 
        @title = "Following"
        @user = User.find_by(id: params[:id])
        @users = @user.following.paginate(page: params[:page], per_page: 10)
        render "show_follow"
    end
       
    def followers 
        @title = "Followers"
        @user = User.find_by(id: params[:id])
        @users = @user.followers.paginate(page: params[:page], per_page: 10)
        render "show_follow"
    end


    private
    def user_params
        params.require(:user).permit :name, :email, :password, :password_confirmation
    end
end
