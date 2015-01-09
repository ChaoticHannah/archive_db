class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :message
      t.string :case_id

      t.timestamps
    end
  end
end
