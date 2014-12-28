class ExecutivesController < ApplicationController

skip_before_filter :authorize

  def index
    @executives = Executive.all
    # render json: @executives, status: 200
  end

  def show
    @executive = Executive.find(params[:id])
  end

  def new
    @executive = Executive.new
    @relationships = @executive.relationships.build
    @organization = @relationships.build_organization
  end

  def create
    @executive = Executive.new(exec_params)
      if @executive.save
        session[:executive_id] = @executive.id
        redirect_to root_path, 
        notice: 'User was successfully created.'
      else
        render 'new'
      end
    # render json: @executive, status: 201
  end

  def edit
    @executive = Executive.find(params[:id])
  end

  def update
    @executive = Executive.find(params[:id])
    if @executive.update_attributes(exec_params)
      redirect_to @executive, 
      notice: 'User was successfully updated.'
    else
      render 'edit'
    end
    # render nothing: true, status: 204
  end

  def destroy
    @executive = Executive.find(params[:id])
    @executive.destroy
    redirect_to root_path
    # render nothing: true, status: 204
  end

private

  def set_executive
    @executive = Executive.find(params[:id])
  end

  def exec_params
    params.require(:executive).permit(
      :username, 
      :password,
      :password_confirmation, 
      :strat_exec_constituent_type, 
      :prefix, 
      :firstname, 
      :lastname, 
      :suffix, 
      :email, 
      :alt_email, 
      :mobile_tel, 
      :mobile_carrier, 
      :office_tel, 
      :home_tel, 
      :fax, 
      :exec_web_url, 
      :exec_description, 
      :address_street, 
      :address_city, 
      :address_state, 
      :address_zip, 
      :demog_spousal_status, 
      :spouse_name, 
      :demog_gender, 
      :demog_ethnicity, 
      :country_of_origin, 
      :demog_sexual_orientation, 
      :social_twitter, 
      :social_linkedin, 
      :social_facebook, 
      :social_googleplus, 
      :social_youtube, 
      :social_pinterest, 
      :social_instagram, 
      :social_photo, 
      :social_blog, 
      :social_platform_dominant, 
      :certifications, 
      :picture_file_name, 
      :picture_file_type, 
      :is_verified_by_staff, 
      :is_verified_by_thirdparty, 
      :exec_comments_on_self, 
      :staff_comments_on_exec, 
      :created_by_exec_id, 
      :is_active, 
      :is_admin, 
      :is_user,
      :relationship,
      relationships_attributes: [:id, :job_title, :is_relationship_current, :_destroy, organization_attributes: [
        :id,
        :org_name, 
        :created_at, 
        :updated_at, 
        :crunchbase_uuid, 
        :org_types_id, 
        :sector_type, 
        :strat_org_constituent_type, 
        :description, 
        :web_url, 
        :parent_or_child_org, 
        :parent_org_id, 
        :size_revenue, 
        :size_employees_structured, 
        :vision, 
        :mission, 
        :goals, 
        :values, 
        :motto_or_tagline, 
        :hq_address_street, 
        :hq_address_city, 
        :hq_address_state, 
        :hq_address_zip, 
        :hq_telephone, 
        :hq_email, 
        :region_headquartered_in, 
        :date_org_founded, 
        :social_twitter, 
        :social_linkedin, 
        :social_facebook, 
        :social_googleplus, 
        :social_youtube, 
        :social_platform_dominant, 
        :org_special_designations, 
        :logo_file_name, 
        :logo_file_type, 
        :is_verified_by_staff, 
        :is_verified_by_thirdparty, 
        :exec_comments_on_org, 
        :staff_comments_on_org, 
        :created_by_exec_id, 
        :certifications, 
        :source_original, 
        :is_active
         ]
       ]
    )
  end
end