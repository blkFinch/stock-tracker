class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_from_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js{render partial: 'users/result'}
        end
      else
        flash.now[:danger] = 'No stock found!'
        render partial:'users/result'
      end
    else
      flash.now[:danger] = 'Invalid stock string'
      render partial:'users/result'
    end
  end

end