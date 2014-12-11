class CreateExecutives < ActiveRecord::Migration
  def change
    create_table :executives do |t|
		t.string :username
		t.string :password_digest
		t.string :strat_exec_constituent_type
		t.string :prefix
		t.string :firstname
		t.string :lastname
		t.string :suffix
		t.string :email
		t.string :alt_email
		t.string :mobile_tel
		t.string :mobile_carrier
		t.string :office_tel
		t.string :home_tel
		t.string :fax
		t.string :exec_web_url
		t.string :exec_description
		t.string :address_street
		t.string :address_city
		t.string :address_state
		t.string :address_zip
		t.string :demog_spousal_status
		t.string :spouse_name
		t.string :demog_gender
		t.string :demog_ethnicity
		t.string :country_of_origin
		t.string :demog_sexual_orientation
		t.string :social_twitter
		t.string :social_linkedin
		t.string :social_facebook
		t.string :social_googleplus
		t.string :social_youtube
		t.string :social_pinterest
		t.string :social_instagram
		t.string :social_photo
		t.string :social_blog
		t.string :social_platform_dominant
		t.string :certifications
		t.string :picture_file_name
		t.string :picture_file_type
		t.string :is_verified_by_staff
		t.string :is_verified_by_thirdparty
		t.string :exec_comments_on_self
		t.string :staff_comments_on_exec
		t.integer :created_by_exec_id
		t.string :is_active
		t.string :is_admin
		t.boolean :is_user

		t.timestamps null: false
    end
  end
end
