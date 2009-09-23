module LeadsHelper
  include WatchersHelper
  include TimelogHelper

  def write_date_ranges
    content_tag(:span,
    content_tag(:span, ",", :id => "date-range-0") +
    content_tag(:span, "#{Date.today},#{Date.today}", :id => "date-range-1") +
    content_tag(:span, "#{Date.today -1},#{Date.today - 1}", :id => "date-range-2") +
    content_tag(:span, "#{Date.today - (Date.today.cwday - 1)%7},#{Date.today - (Date.today.cwday - 1)%7 + 6}", :id => "date-range-3") +
    content_tag(:span, "#{Date.today - 7 - (Date.today.cwday - 1)%7},#{Date.today - 7 - (Date.today.cwday - 1)%7 + 6}", :id => "date-range-4") +
    content_tag(:span, "#{Date.today - 7},#{Date.today}", :id => "date-range-5") +
    content_tag(:span, "#{Date.civil(Date.today.year, Date.today.month, 1)},#{(Date.civil(Date.today.year, Date.today.month, 1) >> 1) -1}", :id => "date-range-6") +
    content_tag(:span, "#{Date.civil(Date.today.year, Date.today.month, 1) << 1},#{((Date.civil(Date.today.year, Date.today.month, 1) << 1) >> 1) -1}", :id => "date-range-7") +
    content_tag(:span, "#{Date.today -30},#{Date.today}", :id => "date-range-8") +
    content_tag(:span, "#{Date.civil(Date.today.year, 1, 1)},#{Date.civil(Date.today.year, 12, 31)}", :id => "date-range-9") ,
    :class => "nodisplay" )
  end
end
