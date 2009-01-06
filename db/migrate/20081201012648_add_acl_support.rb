class AddAclSupport < ActiveRecord::Migration
  def self.up
    drop_table :permission_groups_roles
    drop_table :permission_groups_permissions
    drop_table :permission_groups
    drop_table :permissions
    drop_table :roles_users
    
    create_table "roles", :force => true do |t|
      t.column "title", :string
    end
    create_table "roles_users", :id => false, :force => true do |t|
      t.column "role_id", :integer
      t.column "user_id", :integer
    end
    
    admin_role = Role.create(:title => 'admin')
    Role.create(:title => 'user')
    admin = User.find_by_login('admin')
    admin.roles << admin_role
  end

  def self.down
    drop_table :roles
    drop_table :roles_users
  end
end
