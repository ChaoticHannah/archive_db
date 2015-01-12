# Copyright © notice: Nissan Motor Company.
# ======================================================
# Purpose
# Rake task to create and run migration based on the passed table_name and data.
# Table with such table_name does not exist.
# Data passed in a text file.
# ======================================================
# History
#
# VERSION AUTHOR DATE DETAIL
# 1.0 Halitskaya Victoria 01/12/2015 Created
require 'rails/generators'

namespace :db do
  desc "Creates and fills database table from given data"
  task :create_table_from_data, [:table_name, :file_name] => :environment do |t, args|
    data = File.open(args.file_name, 'rb') { |io| io.read }
    csv = Base64.decode64(data)

    fields = DataTransfer.parse_csv(csv).first.keys.map do |field|
      "#{field}:text"
    end

    Rails::Generators.invoke("active_record:migration", ["create_#{args.table_name}s", *fields])
    Rake::Task["db:migrate"].invoke
  end
end
