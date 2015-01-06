class AddFieldsToCase < ActiveRecord::Migration
  def change
    add_column :cases, :DTS_Inspection_Date_Confirmed__c, :text
    add_column :cases, :Safety_Concern__c, :text
    add_column :cases, :DTS_Notes__c, :text
    add_column :cases, :DTS_Request_Type__c, :text
    add_column :cases, :DTS_Inspection_Date_Set__c, :text
    add_column :cases, :DTS_Field_Inspection__c, :text
    add_column :cases, :DTS_Inspection_Task_Assigned__c, :text
  end
end
