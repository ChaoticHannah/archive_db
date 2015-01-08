require 'test_helper'

describe BaseController do
  before do
    fill_db
  end

  describe "#select" do
    let(:invalid_key) { 'blablabla' }
    let(:valid_key) { Base64.encode64(CONFIG['select_key']) }

    let(:request_params) do
      {
        key: key,
        table_name: 'Case'
      }
    end

    before do
      get :select, request_params
    end

    describe 'when key is invalid' do
      let(:key) { invalid_key }

      it { assert_response :forbidden }
    end

    describe 'when key is valid' do
      let(:key) { valid_key }

      it { assert_response :ok }
    end
  end
end
