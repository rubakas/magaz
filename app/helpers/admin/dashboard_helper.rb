module Admin::DashboardHelper
  # def li_link_to(link_label, link_path, conditions)
  #   style_class = 'active' if current_page?(conditions)
  #   content_tag :li, class: style_class do
  #     link_to link_label, link_path
  #   end
  # end

  def li_link_to(path: link_path, 
    icon_class: link_icon_class,
    label: link_label,
    active_conditions: active_conditions)

    active_class = 'active' if current_page?(active_conditions)

    render partial: 'admin/shared/li_link_to', 
      locals: {
        path: path,
        icon_class: icon_class,
        label: label,
        active_class: active_class
      }
  end
end
