# Name: BaseControllerTest
# Copyright © notice: Nissan Motor Company.
# ======================================================
# Purpose
# Tests for BaseController
# ======================================================
# History
#
# VERSION AUTHOR DATE DETAIL
# 1.0 Halitskaya Victoria 01/08/2015 Created

require 'test_helper'

describe BaseController do
  before do
    fill_db
  end

  # tests 'base_controller#select method'
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

  # tests 'base_controller#save method'
  describe "#save" do
    let(:invalid_key) { 'blablabla' }
    let(:valid_key) { Base64.encode64(CONFIG['save_key']) }
    let(:data) do
      File.open('./test/support/test_data_for_case.txt', 'rb') { |io| io.read }
    end

    let(:request_params) do
      {
        key: key,
        table_name: 'Case',
        data: data
      }
    end

    before do
      Case.delete_all
      post :save, request_params
    end

    describe 'when key is invalid' do
      let(:key) { invalid_key }

      it { assert_response :forbidden }
    end

    describe 'when key is valid' do
      let(:key) { valid_key }

      it { assert_response :ok }

      it 'saves data to database' do
        assert Case.count > 0
      end
    end
  end
end
