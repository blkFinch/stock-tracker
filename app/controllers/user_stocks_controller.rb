class UserStocksController < ApplicationController

  def create
    stock = Stock.find_by_ticker(params[:ticker])
    if stock.blank?
      stock = Stock.new_from_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:success] = "Stock #{@user_stock.stock.name} added to portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    @user_stock = UserStock.where(user_id: current_user, stock_id: stock.id).first
    @user_stock.destroy
    flash[:success] = 'Stock Removed!'
    redirect_to my_portfolio_path
  end
end