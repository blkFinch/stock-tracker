class UsersController < ApplicationController

  def my_portfolio
    @user = current_user
    @user_stocks = @user.stocks
  end

  def show
    @user = User.find(params[:id])
    @user_stocks = @user.stocks
  end

  def my_friends
    @friendships = current_user.friends
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.new(friend_id: @friend.id)

    if current_user.save
      flash[:success] = "Fiend has been added!"
    else
      flash[:danger] = "Something wrong :<"
    end
    redirect_to my_friends_path
  end

  def search
    if params[:search_param].blank?
      flash.now[:danger] = "You have enter an empty search"
    else
      @users = User.search(params[:search_param])
      @users = current_user.except_current_user(@users)
      flash.now[:danger] = "No users found! :<" if @users.blank?
    end
    respond_to do |format|
      format.js { render partial:'friends/result' }
    end
  end
end