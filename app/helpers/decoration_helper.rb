module DecorationHelper

  def decorate_data_field(value, date_field=false)
    if date_field
      value = value.blank? ? "-" : value.strftime("%d-%m-%Y")
    else
      value = value.blank? ? "-" : value
    end
  end



end