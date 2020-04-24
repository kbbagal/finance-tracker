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
  
  def search
    if params[:friend].present?
      @friends_found = User.lookup(params[:friend])
      
      if @friends_found.count
        respond_to do | format |
          format.js {render partial: 'friends/friends_search_result'}
        end
      else
        respond_error_js('Could not find friend')
      end
    else
      respond_error_js('Please enter friend\'s name')
    end
  end

  def respond_error_js(message)
    respond_to do | format |
      flash.now[:alert] = message
      format.js {render partial: 'friends/friends_search_result'}
    end
  end

  def show
    @user = User.find(params[:id])
    @user_stocks = @user.stocks
  end
end
