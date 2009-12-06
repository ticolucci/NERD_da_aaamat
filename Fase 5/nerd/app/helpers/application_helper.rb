module ApplicationHelper

  def hour_options
    options = [
      ["00:00", 0],["01:00", 1],["02:00", 2], ["03:00", 3]
    ]
    options_for_select(options)

  end

  def parse_for_li_from_links links
    return "" if links.nil? || links.empty?

    links = links.split ("</a>")
    res = ""
    links.each do |link|
      res << "<li>"
      res << link
      res << "</a></li>"
    end
    res
  end

end

