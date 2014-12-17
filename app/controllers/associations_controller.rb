class AssociationsController < ApplicationController

	def new
		@association = Association.new
	end

	def create
		@association = Association.create(params.require(:association).permit(:initiator_id, :receiver_id, :assoc_type))
			if @association.save
			redirect_to new_association_path
		end
	end

end