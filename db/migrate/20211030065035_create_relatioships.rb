class CreateRelatioships < ActiveRecord::Migration[5.2]
  def change
    create_table :relatioships do |t|
      t.integer :following_id
      t.integer :follower_id

      t.timestamps
    end
  end
end
