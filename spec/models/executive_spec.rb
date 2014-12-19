require 'rails_helper'
require 'spec_helper'

RSpec.describe Executive, :type => :model do

  before { @executive = Executive.new(name: "Example User", email: "user@example.com",
    password: "fubar", password_confirmation: "fubar") }

  subject{ @executive }

  it { should respond_to(:firstname) }
  it { should respond_to(:lastname) }
  it { should respond_to(:username) }
  it { should respond_to(:email)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate)}

  it { should be_valid }

  describe "when firstname is not present" do
    before { @executive.firstname = " " }
    it { should_not be_valid }
  end

	describe "when lastname is not present" do
		before { @executive.lastname = " " }
		it { should_not be_valid }
	end

	describe "when username is not present" do
		before { @executive.username = " " }
		it { should_not be_valid }
	end

  describe "when email is not present" do
    before { @executive.email = " " }
    it { should_not be_valid }
  end

  describe "when firstname is too long" do
    before { @executive.firstname = "b" * 31 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
        addresses = %w[executive@foo,com executive_at_foo.org example.use@foo.]
        addresses.each do |invalid_address|
            @executive.email = invalid_address
            @executive.should_not be_valid
        end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
        addresses = %w[executive@foo.com executive@foo.jp example+me@foo.edu]
        addresses.each do |valid_address|
            @executive.email = valid_address
            @executive.should be_valid
        end
    end
  end

  describe "when username is taken" do
    before do
      executive_with_same_username = @executive.dup
      executive_with_same_username.username = @executive.username.upcase
      executive_with_same_username.save 
    end

    it { should_not be_valid }
  end  

  describe "when password is not present" do
    before { @executive.password = @executive.password_confirmation = " "}
    it { should_not be_valid }
  end

  describe "when passwords mismatch" do
    before { @executive.password_confirmation = "mismatch"}
    it {should_not be_valid}
  end

  describe "when confirmation is nil" do
    before {@executive.password_confirmation = nil}
    it {should_not be_valid}
  end

  describe "when password is too small" do
    before {@executive.password = @executive.password_confirmation = "a" * 4}
    it {should_not be_valid}
  end

  describe "return value of authentication method" do
    before {@executive.save}
    let(:found_executive) { Executive.find_by_username(@user.username) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it {should_not == user_for_invalid_password}
      specify { user_for_invalid_password.should be_false }
    end
  end
end