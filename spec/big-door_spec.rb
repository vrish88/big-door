require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'ruby-debug'

describe "BigDoor" do
	before do
		@big_door = BigDoor::Base.new(:app_key => '0deee7386916481199b5cbc16e4800b0', :secret_key => '601d2664219e4886a059eeb251baad46')
	end
	
	describe "make get requests" do
		['award_summary', 'level_summary', 'good_summary', 'currency_type', 'currency'].each do |action|
			it "should make a #{action} request" do
				VCR.use_cassette("#{action.match(/([^_]+)_?/)[1]}/#{action}", :record => :none) do
					response = @big_door.send("get_#{action}")
					if action == "currency_type"
						response.should eql([{"can_be_purchased"=>1, "read_only"=>0, "created_timestamp"=>1263933875, "title"=>"Purchase", "modified_timestamp"=>1263933875, "has_dollar_exchange_rate_integrity"=>1, "id"=>1, "can_be_rewarded"=>0, "description"=>nil, "resource_name"=>"currency_type", "can_be_cross_publisher"=>0}, {"can_be_purchased"=>0, "read_only"=>0, "created_timestamp"=>1263933875, "title"=>"Reward", "modified_timestamp"=>1263933875, "has_dollar_exchange_rate_integrity"=>0, "id"=>2, "can_be_rewarded"=>1, "description"=>nil, "resource_name"=>"currency_type", "can_be_cross_publisher"=>0}, {"can_be_purchased"=>1, "read_only"=>0, "created_timestamp"=>1263933875, "title"=>"Hybrid", "modified_timestamp"=>1264002256, "has_dollar_exchange_rate_integrity"=>0, "id"=>3, "can_be_rewarded"=>1, "description"=>"", "resource_name"=>"currency_type", "can_be_cross_publisher"=>0}, {"can_be_purchased"=>0, "read_only"=>0, "created_timestamp"=>1263933875, "title"=>"\303\234ber", "modified_timestamp"=>1263933875, "has_dollar_exchange_rate_integrity"=>1, "id"=>4, "can_be_rewarded"=>0, "description"=>nil, "resource_name"=>"currency_type", "can_be_cross_publisher"=>1}]);
					else
						response.should eql([]);
					end
				end
			end
		end
	end
	
	describe "handle errors" do
		it "should handle a method call that isn't valid" do
			lambda { @big_door.hello_world }.should raise_error ArgumentError
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
	end
end
