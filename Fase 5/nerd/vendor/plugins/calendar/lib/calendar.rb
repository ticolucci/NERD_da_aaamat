module Calendar
    module Helper
        def calendar_field(object, field, options={})
            size = options[:size].nil? ? 12.to_s: options[:size].to_s
            lang = options[:lang].nil? ? 'en': options[:lang]
            date_format = options[:date_format].nil? ? '%Y-%m-%d':options[:date_format]
            skin = options[:skin].nil? ? 'aqua':options[:skin]
            
            <<-EOL
          <link href='/components/calendar/skins/#{skin}/theme.css' type='text/css' rel='stylesheet'>
          <script type='text/javascript' src='/components/calendar/calendar.js'></script>
          <script type="text/javascript" src='/components/calendar/calendar-setup.js'></script>
          <script type='text/javascript' src='/components/calendar/lang/calendar-#{lang}.js'></script> 

          <input type='text' name='#{object}[#{field}]' size=#{size} id='#{object}_#{field}'>
          <img id='#{object}_#{field}_btn' src='/components/calendar/skins/#{skin}/cal.gif' alt='Select Date' width='16' height="16" border="0" style="cursor: pointer;">
          <script type="text/javascript">
                   new calendar('#{object}_#{field}', '#{object}_#{field}_btn','#{date_format}');
          </script>
          EOL
        end
    end
end