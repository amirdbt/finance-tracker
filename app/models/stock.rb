class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks
  validates :name, :ticker, presence: true
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: 'Tpk_772a6fcd897b4eac800879b3c2991f4a',
      # publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      secret_token: 'Tsk_ed169eb46ca5462092d101b53f8edec7',
      endpoint: 'https://sandbox.iexapis.com/stable'
    )
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue StandardError => exception
      nil
    end

  end
end
