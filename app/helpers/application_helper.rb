module ApplicationHelper

  def name_with_status(name, user, current_user = false)
    content_tag(:p) do
      link = if current_user
        link_to(name, edit_user_path(user), class:"name", data:{ current_user:true })
      else
        link_to(name, user_path(user), class:"name")
      end

      link + content_tag(:span, user.status, class:"status status-#{user.status}", data:{url:status_user_path(user)} )
    end
  end

end