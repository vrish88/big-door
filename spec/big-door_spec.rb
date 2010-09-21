require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'ruby-debug'

describe "BigDoor" do
	before do
		@big_door = BigDoor::Base.new(:app_key => '0deee7386916481199b5cbc16e4800b0', :secret_key => '601d2664219e4886a059eeb251baad46')
	end
	
	describe "handle errors" do
		it "should handle a method call that isn't valid" do
			lambda { @big_door.hello_world }.should raise_error ArgumentError
		end
		
		describe "response codes" do
			it "should handle an integer" do
				code = 13
				BigDoor::ResponseCodes.find(code)[:code].should eql(code)
			end
			
			it "should handle a hash" do
				BigDoor::ResponseCodes.find(:http_response => 201)[:code].should eql(0)
			end
			
			it "should raise an error if it's passed something that isn't a hash or number" do
				lambda { BigDoor::ResponseCodes.find("I'm a n00b") }.should raise_error ArgumentError
			end
		end
	end
	
	describe "map BigDoor users to Users object" do
		it "should map params to a user object" do
			params = {"sent_good_summaries"=>[], "level_summaries"=>[], "read_only"=>0, "received_good_summaries"=>[], "guid"=>"a24ff58ca0d711df966120ad2f73afad", "created_timestamp"=>1281043384, "modified_timestamp"=>1281043384, "end_user_login"=>"testers", "award_summaries"=>[], "currency_balances"=>[], "resource_name"=>"end_user"}
			
			user = BigDoor::User.new(params)
			params.keys.each do |meth|
				user.public_methods.should include(meth, "#{meth}=")
			end
		end
		
		it "should get all users" do
			VCR.use_cassette('user/all', :record => :new_episodes) do
				@users = BigDoor::User.all
			end
			@users.each do |user|
				user.class.should eql(BigDoor::User)
			end
		end
		
		it "should create a user with an id that is an email address" do
			email = "fakeemailer@trada.com"
			VCR.use_cassette('user/create', :record => :new_episodes) do
				@response = BigDoor::User.create(:end_user_login => email, :guid => SecureRandom.hex)
			end
			
			@response.end_user_login.should eql(email)
		end
		
		it "should get a specific user" do
			VCR.use_cassette('user/specific', :record => :new_episodes) do
				@user = BigDoor::User.find('testers')
			end

			[*@user].length.should eql(1)
			@user.end_user_login.should eql('testers')
		end
		
		it "should get a specific user that uses an email address" do
			email = 'fakeemailer@trada.com'
			VCR.use_cassette('user/specific', :record => :all) do
				@user = BigDoor::User.find(email)
			end

			[*@user].length.should eql(1)
			@user.end_user_login.should eql(email)
		end
		
		it "should delete a specific user" do
			email = 'super_faker@trada.com'
			VCR.use_cassette('user/create', :record => :new_episodes) do
				@user = BigDoor::User.create(:end_user_login => email)
			end
		
			VCR.use_cassette('user/delete', :record => :all) do
				@user.destroy
			end
		
			VCR.use_cassette('user/blank', :record => :new_episodes) do
				lambda {BigDoor::User.find(email)}.should raise_error BigDoor::BigDoorError
			end
		end
	end
	
	describe "handle currency objects" do
		it "should return all the currency objects" do
			VCR.use_cassette('currency/currency', :record => :new_episodes) do
				@currency = BigDoor::Currency.all
			end
			@currency.class.should eql(BigDoor::Currency)
		end
	end
	
	describe "handle named_transaction objects" do
		it "should return all the named_transaction objects" do
			VCR.use_cassette('named_transaction/named_transactions', :record => :new_episodes) do
				@named_transactions = BigDoor::NamedTransaction.all
			end
			@named_transactions.first.class.should eql(BigDoor::NamedTransaction)
		end
	end
	
	describe "handle named_transaction_group objects" do
		it "should return all the named_transaction_group objects" do
			VCR.use_cassette('named_transaction_group/all', :record => :new_episodes) do
				@named_transactions_group = BigDoor::NamedTransactionGroup.all
			end
			@named_transactions_group.first.class.should eql(BigDoor::NamedTransactionGroup)
			[*@named_transactions_group.first.named_transactions].first.class.should eql(BigDoor::NamedTransaction)
		end
		
		it "should find a named_transaction_group object" do
			VCR.use_cassette('named_transaction_group/all', :record => :new_episodes) do
				@named_transactions_group = BigDoor::NamedTransactionGroup.find(:pub_title__startswith => 'temp_points')
			end

			@named_transactions_group.first.class.should eql(BigDoor::NamedTransactionGroup)
			@named_transactions_group.pub_title.should eql('temp_points')
		end
	end
end
