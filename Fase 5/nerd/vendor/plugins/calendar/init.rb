require "calendar"

#make calendar helper avaliable to app
ActionView::Base.send(:include, Calendar::Helper)

#copy files if not exist
CalendarFileUtils.check_and_install