class StocksController < ApplicationController
  def stock
    if params[:symbol].present?
      @stock = Stock.lookup(params[:symbol])
      if @stock
        respond_to do | format |
          format.js {render partial: 'users/stock_result'}
        end
      else
        respond_error_js('Please provide a valid stock symbol')
      end
    else
      respond_error_js('Please provide a stock symbol')
    end  
  end
  
  def respond_error_js(message)
    respond_to do | format |
      flash.now[:alert] = message
      format.js {render partial: 'users/stock_result'}
    end
  end
end
