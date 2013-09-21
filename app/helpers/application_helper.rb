module ApplicationHelper
  def datetime_format(datetime)
    datetime.localtime.strftime('%Y/%m/%d %H:%M %Z')
  end
end
