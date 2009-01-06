class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :commentable_id
      t.string :commentable_type
      t.text :body
      
      t.integer :comment_count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
