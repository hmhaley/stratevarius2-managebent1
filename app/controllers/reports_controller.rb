class ReportsController < ApplicationController

	def org_associations
		@organizations = Organization.all.map {|a| ["#{a.org_name}", a.org_name]}
		@organizations.unshift(["** Please Select an Organization **", nil])

		if params[:organization]
			@associations = Organization.get_org_associations(params[:organization])
		else
			@associations = []
		end
	end

end