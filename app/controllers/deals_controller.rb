class DealsController < BaseController

  # before_action :login_required, :except => [:accepted]
  # before_action :find_organization, :only => [:accepted, :pending, :denied]
  # before_action :require_current_organization, :only => [:accept, :deny, :pending, :destroy]

  def deny
    @organization = Organization.find(params[:organization_id])
    @deal = @organization.deals.find(params[:id])

    respond_to do |format|
      if @deal.update_attributes(:deal_status => DealStatus[:denied]) && @deal.reverse.update_attributes(:deal_status => DealStatus[:denied])
        flash[:notice] = :the_deal_was_denied.l
        format.html { redirect_to denied_organization_deals_path(@organization) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def accept
    @organization = Organization.find(params[:organization_id])
    @deal = @organization.deals_not_initiated_by_me.find(params[:id])

    respond_to do |format|
      if @deal.update_attributes(:deal_status => DealStatus[:accepted]) && @deal.reverse.update_attributes(:deal_status => DealStatus[:accepted])
        flash[:notice] = :the_deal_was_accepted.l
        format.html {
          redirect_to accepted_organization_deals_path(@organization)
        }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def denied
    @organization = Organization.find(params[:organization_id])
    @deals = @organization.deals.where("deal_status_id = ?", DealStatus[:denied].id).page(params[:page])

    respond_to do |format|
      format.html
    end
  end


  def accepted
    @organization = Organization.find(params[:organization_id])
    @partner_count = @organization.accepted_deals.count
    @pending_deals_count = @organization.pending_deals.count

    @deals = @organization.deals.accepted.page(params[:page]).per(12)

    respond_to do |format|
      format.html
    end
  end

  def pending
    @organization = Organization.find(params[:organization_id])
    @deals = @organization.deals.where("initiator = ? AND deal_status_id = ?", false, DealStatus[:pending].id)

    respond_to do |format|
      format.html
    end
  end

  def show
    @deal = Deal.find(params[:id])
    @organization = @deal.organization

    respond_to do |format|
      format.html
    end
  end


  def create
    @organization = Organization.find(params[:organization_id])
    @deal = Deal.new(:organization_id => params[:organization_id], :partner_id => params[:partner_id], :initiator => true )
    @deal.deal_status_id = DealStatus[:pending].id
    reverse_deal = Deal.new
    reverse_deal.deal_status_id = DealStatus[:pending].id
    reverse_deal.organization_id, reverse_deal.partner_id = @deal.partner_id, @deal.organization_id

    respond_to do |format|
      if @deal.save && reverse_deal.save
        OrganizationNotifier.deal_request(@deal).deliver if @deal.partner.notify_partner_requests?
        format.html {
          flash[:notice] = :deal_requested.l_with_args(:partner => @deal.partner.login)
          redirect_to accepted_organization_deals_path(@organization)
        }
        format.js {@text = "#{:requested_deal_with.l} #{@deal.partner.login}."}
      else
        flash.now[:error] = :deal_could_not_be_created.l
        format.html { redirect_to organization_deals_path(@organization) }
        format.js {@text = "#{:deal_request_failed.l}."}
      end
    end
  end

  def destroy
    @organization = Organization.find(params[:organization_id])
    @deal = Deal.find(params[:id])
    Deal.transaction do
      @deal.destroy
      @deal.reverse.destroy
    end
    respond_to do |format|
      format.html { redirect_to accepted_organization_deals_path(@organization) }
    end
  end

  private

  def deal_params
    params[:deal].permit(:deal_status, :initiator, :organization, :organization_id)
  end

end