class TimesheetsController < ApplicationController
	def index
		@timesheets = Timesheet.order(:date)
	end
end
