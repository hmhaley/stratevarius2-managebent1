class AddDescriptionToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :crunchbase_uuid, :string
    add_column :organizations, :org_types_id, :string
	add_column :organizations, :sector_type, :string
	add_column :organizations, :strat_org_constituent_type, :string
	add_column :organizations, :description, :text
	add_column :organizations, :web_url, :string
	add_column :organizations, :parent_or_child_org, :string
	add_column :organizations, :parent_org_id, :integer
	add_column :organizations, :size_revenue, :string
	add_column :organizations, :size_employees_structured, :string
	add_column :organizations, :vision, :string
	add_column :organizations, :mission, :string
	add_column :organizations, :goals, :string
	add_column :organizations, :values, :string
	add_column :organizations, :motto_or_tagline, :string
	add_column :organizations, :hq_address_street, :string
	add_column :organizations, :hq_address_city, :string
	add_column :organizations, :hq_address_state, :string
	add_column :organizations, :hq_address_zip, :string
	add_column :organizations, :latitude, :float
    add_column :organizations, :longitude, :float
	add_column :organizations, :hq_telephone, :string
	add_column :organizations, :hq_email, :string
	add_column :organizations, :region_headquartered_in, :string
	add_column :organizations, :date_org_founded, :datetime
	add_column :organizations, :social_twitter, :string
	add_column :organizations, :social_linkedin, :string
	add_column :organizations, :social_facebook, :string
	add_column :organizations, :social_googleplus, :string
	add_column :organizations, :social_youtube, :string
	add_column :organizations, :social_platform_dominant, :string
	add_column :organizations, :org_special_designations, :text
	add_column :organizations, :logo_file_name, :string
	add_column :organizations, :logo_file_type, :string
	add_column :organizations, :is_verified_by_staff, :string
	add_column :organizations, :is_verified_by_thirdparty, :string
	add_column :organizations, :exec_comments_on_org, :text
	add_column :organizations, :staff_comments_on_org, :text
	add_column :organizations, :created_by_exec_id, :integer
	add_column :organizations, :certifications, :text
	add_column :organizations, :source_original, :string
	add_column :organizations, :is_active, :string

  end
end
