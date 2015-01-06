require 'test_helper'

class BaseControllerTest < ActionController::TestCase
  describe "#select" do
    let(:invalid_key) { 'blablabla' }
    let(:valid_key) { CONFIG['select_key'] }

    it 'forbids acccess if key is invalid' do
      get :select, key: invalid_key
      assert_response :forbidden
    end

    it 'allows access if key is valid' do
      get :select, key: valid_key
      assert_response :ok
    end
  end
end
