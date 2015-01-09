class AddIndexes < ActiveRecord::Migration
  def change
    add_index :tasks, :AccountId
    add_index :users, :dealer_code
    add_index :cases, [:AccountId, :Id, :RecordTypeId, :CaseNumber], name: 'add_index_on_cases'
  end
end
