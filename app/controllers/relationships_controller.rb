class RelationshipsController < ApplicationController

skip_before_filter :authorize

  def index
    @relationships = Relationship.all
    render json: relationships, status: 200
  end

  def show
  	@relationship = Relationship.find(params[:id])
  end

  def new
  	@relationship = Relationship.new
  end

  def create
    @relationship = Organization.new(rel_params)
    if @relationship.save
    	redirect_to relationships_path
    else
    	render 'new'
    end
    render json: relationship, status: 201
  end

  def edit
  	@relationship = Organization.find(params[:id])
  end

  def update
    @relationship = Relationship.find(params[:id])
	if @relationship.update_attributes(rel_params)
		redirect_to relationships_path
	else
		render 'edit'
	end
    render nothing: true, status: 204
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy
    redirect_to relationships_path
    render nothing: true, status: 204
  end

  private

  def rel_params
    params.require(:relationship).permit(
    executive_id, 
    organization_id, 
    :relationship_type, 
    :job_title, 
    :is_relationship_current, 
    :is_relationship_primary, 
    :start_date_month, 
    :start_date_year, 
    :end_date_month, 
    :end_date_year, 
    :is_verified_by_org, 
    :is_verified_by_staff, 
    :is_verified_by_thirdparty, 
    :created_by_exec_id, 
    :exec_comments_on_relationship, 
    :staff_comments_on_relationship, 
    :created_at, 
    :updated_at,
    :organization,
    :organization_attributes
    # : [:id, :name, :_destroy], 
    )
  end

end