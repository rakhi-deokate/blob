module ProductsHelper

  # https://github.com/rails/rails/issues/26875
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == self.sort_column ? "current #{self.sort_direction}" : nil
    direction = column == self.sort_column && self.sort_direction == "asc" ? "desc" : "asc"
    link_to title, request.parameters.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

end
