class CreateDiggs < ActiveRecord::Migration
  def self.up
    create_table :diggs do |t|
      t.integer :user_id
      t.integer :diggable_id
      t.string  :diggable_type
      
      t.timestamps
    end
  end

  def self.down
    drop_table :diggs
  end
end
