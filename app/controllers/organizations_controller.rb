class OrganizationsController < ApplicationController

skip_before_filter :authorize

  def index
    @organizations = Organization.all
    # render json: @organizations, status: 200
  end

  def show
  	@organization = Organization.find(params[:id])
    @partner_count = @organization.accepted_deals.count
    @accepted_deals = @organization.accepted_deals.limit(5).to_a.collect{|f| f.partner }
    @pending_deals_count = @organization.pending_deals.count()
  end

  def new
  	@organization = Organization.new
  	@organization.relationships.build
  	@inviter_id = params[:id]
    @inviter_code = params[:code]
  end

  def create
    @organization = Organization.new(org_params)
    if @organization.save
    	create_deal_with_inviter(@organization, params)
      # flash[:notice] = :email_signup_thanks.l_with_args(:email => @user.email)
      # redirect_to signup_completed_user_path(@user)
    	redirect_to organizations_path
    else
    	render 'new'
    end
    # render json: @organization, status: 201
  end

  def edit
  	@organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
	if @organization.update_attributes(org_params)
		redirect_to organizations_path
	else
		render 'edit'
	end
    # render nothing: true, status: 204
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to organizations_path
    # render nothing: true, status: 204
  end

  def create_deal_with_inviter(organization, options = {})
    unless options[:inviter_code].blank? or options[:inviter_id].blank?
      partner = Organization.find(options[:inviter_id])

      if partner && partner.valid_invite_code?(options[:inviter_code])
        accepted    = DealStatus[:accepted]
        @deal = Deal.new(:organization_id => partner.id,
          :partner_id => organization.id,
          :deal_status => accepted,
          :initiator => true)

        reverse_deal = Deal.new(:organization_id => organization.id,
          :partner_id => partner.id,
          :deal_status => accepted )

        @deal.save!
        reverse_deal.save!
      end
    end
  end

 private

  def org_params
    params.require(:organization).permit(
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
		:is_active,
    :notify_partner_requests,
		executive_ids: [],
    )
  end

end