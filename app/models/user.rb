class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def stock_already_added?(ticker)
    stock = Stock.find_by_ticker(ticker)
    return false unless stock
    user_stocks.where(stock_id: stock.id).exists?
  end

  def under_stock_limit?
    (user_stocks.count < 10)
  end

  def can_add_stock?(ticker)
    under_stock_limit? && !stock_already_added?(ticker)
  end

  def stock_add_errors(ticker)
    s = []
    if !under_stock_limit?
      s << "You have reached your stock limit of 10"
    end
    if stock_already_added?(ticker)
      s << "You are already tracking that stock"
    end
    s
  end
end