class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    iex_client_credentials = Rails.application.credentials.iex_client

    client = IEX::Api::Client.new(
      publishable_token: iex_client_credentials[:sandbox_api][:publishable_token],
      secret_token: iex_client_credentials[:sandbox_api][:secret_token],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    client.price(ticker_symbol)
  end
end
