module CalendarHelper

  def calendar_with_time_for(field_id)
    include_calendar_headers_tags
    image_tag("calendar.png", {:id => "#{field_id}_trigger",:class => "calendar-trigger"}) +
    javascript_tag("Calendar.setup({inputField : '#{field_id}', ifFormat : '%Y-%m-%d %H:%M:%S', button : '#{field_id}_trigger', showsTime : true, time24 : false });")
  end

end

