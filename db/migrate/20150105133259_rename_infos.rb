class RenameInfos < ActiveRecord::Migration
  def change
  	rename_table :infos, :tasks
  end
end
