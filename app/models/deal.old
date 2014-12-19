class Deal < ActiveRecord::Base

	@@daily_request_limit = 12
	cattr_accessor :daily_request_limit

	belongs_to :organization
	belongs_to :partner, :class_name => "Organization", :foreign_key => "partner_id"   
	has_enumerated :deal_status, :class_name => 'DealStatus', :foreign_key => 'deal_status_id'

	validates_presence_of   :deal_status
	validates_presence_of   :organization
	validates_presence_of   :partner
	validates_uniqueness_of :partner_id, :scope => :organization_id
	validate :cannot_request_if_daily_limit_reached
	validates_each :organization_id do |record, attr, value|
    record.errors.add attr, 'can not be same as partner' if record.organization_id.eql?(record.partner_id)
  end
  
  # named scopes
  scope :accepted, lambda {
    #hack: prevents DealStatus[:accepted] from getting called before the deal_status records are in the db (only matters in testing ENV)
    where("deal_status_id = ?", DealStatus[:accepted].id)
  }
  
  def cannot_request_if_daily_limit_reached  
    if new_record? && initiator && organization.has_reached_daily_partner_request_limit?
      errors.add(:base, "Sorry, you'll have to wait a little while before requesting any more deals.") 
    end
  end  
    
  before_validation(:on => :create){:set_pending}
  after_save :notify_requester, :if => Proc.new{|d| d.accepted? && d.initiator }
  
  def reverse
    Deal.where('organization_id = ? and partner_id = ?', self.partner_id, self.organization_id).first
  end

  def denied?
    deal_status.eql?(DealStatus[:denied])
  end
  
  def pending?
    deal_status.eql?(DealStatus[:pending])
  end
  
  def accepted?
    deal_status.eql?(DealStatus[:accepted])    
  end
  
  def self.partners?(organization, partner)
    where("organization_id = ? AND partner_id = ? AND deal_status_id = ?", organization.id, partner.id, DealStatus[:accepted].id).first
  end
  
  # def notify_requester
  #   OrganizationNotifier.deal_accepted(self).deliver
  # end
    
private
  def set_pending
    deal_status_id = DealStatus[:pending].id
  end  
end