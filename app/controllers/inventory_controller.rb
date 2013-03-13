class InventoryController < ApplicationController
	before_filter :check_session
	layout 'inventory'

	def record
		@nav = "record"
		if request.post? and params[:ops]
			params[:ops].each { |k, v|
				
			}
		end
	end
end
