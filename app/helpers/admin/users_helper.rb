module Admin::UsersHelper
  def link_to_user_roles(user)
    user.roles.collect do |role|
      role.title
    end.join('<br />')
  end
end
