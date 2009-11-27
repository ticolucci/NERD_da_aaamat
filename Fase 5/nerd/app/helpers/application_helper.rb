module ApplicationHelper

  def hour_options
    options = [
      ["00:00", 0],["01:00", 1],["02:00", 2], ["03:00", 3]
    ]
    options_for_select(options)

  end

end