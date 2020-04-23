class UsersController < ApplicationController
  def my_portfolio
    @user_stocks = current_user.stocks
  end

  def stock
    if params[:symbol].present?
      @stock = Stock.lookup(params[:symbol])
      if @stock
        render 'users/my_portfolio'
      else
        flash[:alert] = 'Please provide a valid stock symbol'
        redirect_to my_portfolio_path
      end
    else
      flash[:alert] = 'Please provide a stock symbol'
      redirect_to my_portfolio_path
    end
  end

  def my_friends
    @friends = current_user.friends
  end
end
