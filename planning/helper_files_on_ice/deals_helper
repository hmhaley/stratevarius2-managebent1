module DealsHelper

  def deal_control_links(deal)
    html = case deal.deal_status_id
      when DealStatus[:pending].id
        "#{(link_to(:accept.l, accept_organization_deal_path(deal.organization, deal), :method => :patch, :class => 'button positive') unless deal.initiator?)} #{link_to(:deny.l, deny_organization_deal_path(deal.organization, deal), :method => :patch, :class => 'button negative')}"
      when DealStatus[:accepted].id
        "#{link_to(:remove_this_partner.l, deny_organization_deal_path(deal.organization, deal), :method => :patch, :class => 'button negative')}"
      when DealStatus[:denied].id
    		"#{link_to(:accept_this_request.l, accept_organization_deal_path(deal.organization, deal), :method => :patch, :class => 'button positive')}"
    end
    
    html.html_safe
  end

end