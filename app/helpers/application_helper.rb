module ApplicationHelper
  def convert_date(date)
    date.strftime("%d/%m/%y %H:%M")
  end
end
