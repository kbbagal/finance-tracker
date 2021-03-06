class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true
  def self.lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_publishable_key,
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price:client.price(ticker_symbol))
    rescue Exception => e
      return nil
    end
  end

  def self.does_exist(ticker_symbol)
    find_by(ticker: ticker_symbol)
  end
end
