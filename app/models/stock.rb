class Stock < ApplicationRecord
  def self.lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_publishable_key,
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    begin
      client.price(ticker_symbol)
    rescue
      return nil
    end
  end
end
