module DecorationHelper

  def decorate_data_field(value, date_field=false)
    if date_field
      value = value.blank? ? "-" : value.strftime("%d-%m-%Y")
    else
      value = value.blank? ? "-" : value
    end
  end

  def decorate_boolean_field(value)
    if value == true
      "<span class='icon-ok'></span>".html_safe
    else
      "-"
    end
  end


end