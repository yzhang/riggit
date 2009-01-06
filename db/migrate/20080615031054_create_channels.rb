class CreateChannels < ActiveRecord::Migration
  def self.up
    create_table :channels do |t|
      t.string :name
      t.string :sort_by
      t.integer :minimal_diggs
      t.integer :weight
      t.boolean :need_moderate, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :channels
  end
end
