class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def tracking_stock?(ticker_symbol)
    
    stock = Stock.does_exist(ticker_symbol)

    return false unless stock

    stocks.where(id: stock.id).exists?
  end

  def under_tracking_threshold?
    stocks.count <= 10
  end

  def can_track_stock?(ticker_symbol)
    !tracking_stock?(ticker_symbol) && under_tracking_threshold?
  end

  def display_name
    return first_name if first_name

    "Anonymous"
  end
end
