class ChangeRelatioshipsToRelationships < ActiveRecord::Migration[5.2]
  def change
    rename_table :relatioships, :relationships
  end
end