class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(params.require(:user).permit(:name, :email, :password))
        if @user.save
            flash[:success] = @welcome = "welcome to the site, #{@user.name}"
            redirect_to users_path
        else
            flash.now[:danger] = "Unalbe to create new user"
            render 'new'
        end
    end

    def show
        @user = User.find(param[:id])
    rescue
        flash[:danger] = "Unable to find user"
        redirect_to users_path
    end
end