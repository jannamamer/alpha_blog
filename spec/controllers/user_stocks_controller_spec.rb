# frozen_string_literal: true

require 'rails_helper'

describe UserStocksController do
  fixtures :users, :stocks, :user_stocks
  let(:user) { users(:regular) }

  before do
    sign_in(user, scope: :user)
  end

  describe 'POST #create' do
    let(:params) { { ticker: 'b' } }

    it 'creates a user stock' do
      expect(Stock.count).to eq(1)
      expect(UserStock.count).to eq(1)

      post :create, params: params

      expect(Stock.count).to eq(2)
      expect(UserStock.count).to eq(2)
      expect(response).to redirect_to(stocks_path)
    end
  end

  describe 'PUT #destroy' do
    let(:params) { { id: 1 } }

    it 'destroys user stock' do
      expect(Stock.count).to eq(1)
      expect(UserStock.count).to eq(1)

      put :destroy, params: params

      expect(Stock.count).to eq(1)
      expect(UserStock.count).to eq(0)
      expect(response).to redirect_to(stocks_path)
    end
  end
end
