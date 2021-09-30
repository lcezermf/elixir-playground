defmodule DateParser do
  def day() do
    "\\d{1,2}"
  end

  def month() do
    "\\d{1,2}"
  end

  def year() do
    "\\d{4}"
  end

  def day_names() do
    "[A-Z][a-z]*"
  end

  def month_names() do
    "[A-Z][a-z]*"
  end

  def capture_day() do
    "(?<day>#{day()})"
  end

  def capture_month() do
    "(?<month>#{month()})"
  end

  def capture_year() do
    "(?<year>#{year()})"
  end

  def capture_day_name() do
    "(?<day_name>#{day_names()})"
  end

  def capture_month_name() do
    "(?<month_name>#{month_names()})"
  end

  def capture_numeric_date() do
    "(?<day>#{day()})/(?<month>#{month()})/(?<year>#{year()})"
  end

  def capture_month_name_date() do
    "#{capture_month_name()} #{capture_day()}, #{capture_year()}"
  end

  def capture_day_month_name_date() do
    "#{capture_day_name()}, #{capture_month_name()} #{capture_day()}, #{capture_year()}"
  end

  def match_numeric_date() do
    # Please implement the match_numeric_date/0 function
  end

  def match_month_name_date() do
    # Please implement the match_month_name_day/0 function
  end

  def match_day_month_name_date() do
    # Please implement the match_day_month_name_date/0 function
  end
end
