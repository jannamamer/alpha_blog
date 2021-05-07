# frozen_string_literal: true

require 'rails_helper'

describe StocksController do
  fixtures :users
  let(:user) { users(:regular) }

  before do
    sign_in(user, scope: :user)
  end

  describe 'GET #index' do
    subject { get :index }
    it { is_expected.to be_successful }
  end
end
