class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
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
    return "#{first_name} #{last_name}" if first_name || last_name

    "Anonymous"
  end

  def self.lookup(name)
    where('lower(first_name) LIKE lower(?) OR lower(last_name) LIKE lower(?)', "%#{name}%", "%#{name}%")
  end

  def is_following_friend?(friend)
    friends.where(id: friend).exists?
  end
end
