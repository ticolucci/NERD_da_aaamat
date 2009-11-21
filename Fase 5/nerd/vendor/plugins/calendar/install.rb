directory = File.join(RAILS_ROOT, '/vendor/plugins/fckeditor/')
require 'fileutils'
require "#{directory}/lib/calendar_version"
require "#{directory}/lib/calendar_file_utils"

puts "** Installing Calendar Plugin version #{CalendarVersion.current}...."

CalendarFileUtils.install(false)

puts "** Successfully installed Calendar Plugin version #{CalendarVersion.current}"