# Name: TestCase
# Copyright © notice: Nissan Motor Company.
# ======================================================
# Purpose
# Class that contains helper methods for tests and shared
# examples
# ======================================================
# History
#
# VERSION AUTHOR DATE DETAIL
# 1.0 Halitskaya Victoria 01/08/2015 Created

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/unit'
require 'minitest/rails'
require 'csv'
require 'base64'

class ActiveSupport::TestCase
  # fills test database with test data
  def fill_db
    data = File.open('./test/support/test_data_for_case.txt', 'rb') { |io| io.read }
    Case.save_data_to_db(data) unless Case.any?
  end

  # parses csv and returns array of objects
  def parse_csv(csv)
    objects = CSV.parse(csv)
    headers = objects.shift
    objects.to_a.map! { |row| Hash[headers.zip(row)] }
  end

  # converts given objects to csv format
  def convert_to_csv(obj_array)
    CSV.generate(headers: true) do |csv|
      csv << obj_array.first.keys

      obj_array.each do |object|
        csv << object.values
      end
    end
  end

  # parses encoded text
  def parse_base64(encoded_data)
    Base64.decode64(encoded_data)
  end

  # encodes given data to base64 format
  def convert_to_base64(csv)
    Base64.encode64(csv)
  end
  #
  # Shared examples
  #
  def self.it_saves_object_to_db
    it 'saves object to database' do
      refute_equal subject.count, 0
    end
  end

  def self.it_behaves_like_normal_model
    let(:acoount_id) { user.account_id }
    let(:user) do
      User.create(dealer_code: '1111',
                  password: '0000',
                  account_id: 'bbb111bbq')
    end

    describe '#save_to_db' do
      let(:invlaid_attribute) { { invalid_key: 1 } }
      let(:missing_attribute) { subject.attribute_names.first }
      let(:model_attributes) { subject.new.attributes  }

      let(:encoded_data) do
        csv = convert_to_csv([attributes])
        convert_to_base64(csv)
      end

      before do
        subject.delete_all
        subject.save_data_to_db(encoded_data)
      end

      describe 'when all attributes valid' do
        let(:attributes) { model_attributes }

        it_saves_object_to_db
      end

      describe 'when there are invalid attributes' do
        let(:attributes) { model_attributes.merge(invlaid_attribute) }

        it_saves_object_to_db
      end

      describe 'when some attributes are missed' do
        let(:attributes) { model_attributes.except(missing_attribute) }

        it_saves_object_to_db
      end
    end

    describe '#select_from_db' do
      let(:result) { subject.select_data_from_db(select_params) }
      let(:parsed_result) do
        csv = parse_base64(result)
        objects = parse_csv(csv)
      end

      before do
        subject.delete_all
      end

      describe 'when table is empty' do
        let(:select_params) { {} }

        it 'return nothing' do
          refute result
        end
      end

      describe 'when table is not emty' do
        before do
          10.times { subject.create(AccountId: acoount_id) }
          5.times { subject.create }
        end

        describe 'when no offset-limit parameters specified' do
          let(:select_params) { {} }

          it 'returns first 10 records by default' do
            assert_equal parsed_result.count, 10
          end

          it 'returns appropriate records' do
            assert_equal parsed_result.sample['AccountId'], subject.first.AccountId
          end
        end

        describe 'when offset-limit parameters specified' do
          let(:select_params) { { offset: 1, limit: 5 } }

          it 'returns appropriate number of records' do
            assert_equal parsed_result.count, 5
          end

          it 'returns appropriate records' do
            assert_equal parsed_result.sample['AccountId'], subject.last.AccountId
          end
        end
      end
    end
  end
end
