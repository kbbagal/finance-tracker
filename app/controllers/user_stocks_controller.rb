class UserStocksController < ApplicationController
  def create
    stock = Stock.find_by(ticker: params[:ticker])

    if !stock.present?
      raw_stock = Stock.lookup(params[:ticker])
      stock = Stock.create(ticker: raw_stock.ticker, name: raw_stock.name, last_price: raw_stock.last_price)
    end

    user_stock = UserStock.where(user: current_user, stock: stock)
    
    if user_stock.present?
      flash[:alert] = 'Stock already present'
    else
      user_stock = UserStock.new(user: current_user, stock: stock)
      
      if user_stock.save
        flash[:notice] = 'Stock added to portfolio'
      else
        flash[:alert] = 'Could not add the stock!'
      end
    end

    redirect_to :my_portfolio
  end

  def destroy
    UserStock.destroy_by(user: current_user, stock: Stock.find(params[:id]))
    flash[:notice] = 'Stock removed from portfolio'

    redirect_to :my_portfolio
  end
end
