class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks


  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end


  def self.new_from_lookup(ticker_symbol)
    begin
      client = IEX::Api::Client.new(publishable_token: 'pk_2a6f227447a24fa79aae2b6b0cc48a49')
      looked_up_stock = client.quote(ticker_symbol)
      new(name: looked_up_stock.company_name,
          ticker: looked_up_stock.symbol, last_price: strip_commas(looked_up_stock.latest_price))
    rescue Exception => e
      return nil
    end
  end

  def self.strip_commas (price_string)
    price_string.to_s.gsub(",", "")
  end
end
