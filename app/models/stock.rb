class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      # secret_token: 'sk_a3a41e9812194499936da13157bd3ceb',
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    client.price(ticker_symbol)
  end
end
