module StaticPagesHelper
  
  # Adds a link to the navbar
  def nav_item(item, path)
    content_tag :li, class: "nav-item" do
      link_to item, path, class: "nav-link"
    end
  end
  
  # Adds an icon link to the navbar
  def nav_icon(icon, path)
    content_tag :li, class: "nav-item p-0" do
      # for materials-icon
      # link_to eval("mi.#{icon}"), path, class: "nav-link"
      # for font-awesome
      link_to icon(icon, class: "fa-fw fa-lg"), path, class: "nav-link"
    end
  end
    
  # Adds a dropdown link to the navbar
  def dropdown(item, path, &block)
    content_tag :li, class: "nav-item dropdown" do
      (capture(&block) if block_given?) <<
      (link_to item, path, class: "nav-link",
                          id:"navbarDropdown", 
                          data: { toggle: "dropdown" }, 
                          aria: { haspopup: true, expanded: false })
    end
  end

  # Adds a dropdown icon link to the navbar
  def dropdown_icon(icon, path, &block)
    content_tag :li, class: "nav-item dropdown" do
      (capture(&block) if block_given?) <<
      # for materials-icon
      # (link_to eval("mi.#{icon}"), path, class: "nav-link",
      # for font-awesome
      (link_to icon(icon, class: "fa-fw fa-lg"), path, class: "nav-link",
                          id:"navbarDropdown", 
                          data: { toggle: "dropdown" }, 
                          aria: { haspopup: true, expanded: false })
    end
  end
  
  # Adds a dropdown menu to the dropdown link
  def dropdown_menu(class_option="dropdown-menu",&block)
    content_tag :div, class: class_option, 
                      aria: { labelledby: "navbarDropdown" } do
      capture(&block) if block_given?
    end
  end
  
  # Adds a dropdown link to the dropdown menu
  def dropdown_item(item, path)
    link_to item, path, class: "dropdown-item"
  end
  
  # Adds a dropdown icon link to the dropdown menu
  def dropdown_item_icon(icon, path, label)
    # for materials-icon
    # link_to eval("mi.#{icon}").css_class('center-vertically').to_s << 
    #         " #{label}", path, class: "dropdown-item"
    # for font-awesome
    link_to icon(icon, label, class: "fa-fw"), path, class: "dropdown-item"
  end
  
  # Adds a divider to the dropdown menu
  def dropdown_divider
    content_tag :div, "", class: "dropdown-divider"
  end
end
