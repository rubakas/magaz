module Admin::DashboardHelper
  # def li_link_to(link_label, link_path, conditions)
  #   style_class = 'active' if current_page?(conditions)
  #   content_tag :li, class: style_class do
  #     link_to link_label, link_path
  #   end
  # end

  def li_link_to(link_path: link_path, 
    active_conditions: active_conditions,
    link_icon_class: link_icon_class,
    link_label: link_label)

    active_class = 'active' if current_page?(active_conditions)

    render partial: 'admin/shared/li_link_to', 
      locals: {
        link_path: link_path,
        active_class: active_class,
        link_icon_class: link_icon_class,
        link_label: link_label
      }
  end
end
