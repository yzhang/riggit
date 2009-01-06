class AddAuthorizationSupport < ActiveRecord::Migration
  def self.require_all_controllers(path)
    Dir.new(path).entries.collect do |e|
      entry = File.join(path, e)
  
      if e[0] != 46 # 46 = '.' 
        if File.directory?(entry)
          require_all_controllers(entry)
        elsif e =~ /controller.rb$/
          ApplicationController.require_or_load entry
        end
      end
    end
  end
  
  def self.up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :roles_users do |t|
        t.references :user
        t.references :role
    end
    
    create_table :permissions do |t|
      t.string :name
      t.string :controller
      t.string :action

      t.timestamps
    end
    
    create_table :permission_groups do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :permission_groups_roles, :id => false do |t|
      t.integer :role_id
      t.integer :permission_group_id
    end
    
    create_table :permission_groups_permissions, :id => false do |t|
      t.integer :permission_id
      t.integer :permission_group_id
    end

    # Initial site
    @channel = Channel.create(:name => 'Popular', :minimal_diggs => 0, :sort_by => 'created_at', :weight => 1, :need_moderate => true)
    @category = Category.create(:name => 'News')
    Site.create(:name => 'Digg Demo', :default_channel => @channel)
    
    # Initial admin
    admin = User.create(:login => 'admin', :email => 'admin@letrails.cn', :password => 'password', :password_confirmation => 'password')
    
    # Initial story
    @story = Story.create(:title => 'Riggit: A digg clone based on Ruby on Rails!',
                  :url => 'http://riggit.org',
                  :summary => '<p>Welcome to use riggit, you can always find updates of riggit at http://code.google.com/p/riggit</p>',
                  :user_id => admin.id,
                  :category_id => @category.id)
    
    @channel.moderated_stories << @story
  end

  def self.down
    drop_table :permission_groups_roles
    drop_table :permission_groups_permissions
    drop_table :permission_groups
    drop_table :permissions
    drop_table :roles_users
    drop_table :roles
  end
end
