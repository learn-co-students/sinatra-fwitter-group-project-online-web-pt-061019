class AddColumnToTweets < ActiveRecord::Migration
  
  def change
    add_column :tweets, :user_id, :integer
  end

  def up
    change_table :tweets do |t|
      t.timestamps
    end
  end

  def down
    remove_column :tweets, :created_at
    remove_column :tweets, :updated_at
  end

end
