class Association < ActiveRecord::Base

	belongs_to :initiator, class_name: "Organization",
	  foreign_key: :initiator_id, inverse_of: :initiators
	belongs_to :receiver, class_name: "Organization",
	  foreign_key: :receiver_id, inverse_of: :receivers

	belongs_to :executive, class_name: "Executive",
	  foreign_key: :created_by_exec_id

	has_enumerated :confirmation_status, :class_name => 'ConfirmationStatus', :foreign_key => 'confirmation_status_id'

# def self.get_my_org_associations(assoc_type)
# 		Organization.find_by_sql(["select initiator_id, org_name, 'associations_initiated_by' from (SELECT organization.id, organization.org_name, a.code as acode, a.name as aname FROM airports AS d INNER JOIN flights AS f ON d.id = f.departure_airport_id INNER JOIN airports AS a ON f.arrival_airport_id = a.id WHERE a.code = ? or d.code = ?) AS flights where dcode != ?
# 	    union
# 			select acode, aname, 'departure' from (SELECT d.code as dcode, d.name as dname, a.code as acode, a.name as aname FROM airports AS d INNER JOIN flights AS f ON d.id = f.departure_airport_id INNER JOIN airports AS a ON f.arrival_airport_id = a.id WHERE a.code = ? or d.code = ?) AS flights2 where acode != ?;", code, code, code, code, code, code])
# 	end

end
