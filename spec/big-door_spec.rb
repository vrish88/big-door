require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'ruby-debug'

describe "BigDoor" do
	before do
		@big_door = BigDoor::Base.new(:app_key => '0deee7386916481199b5cbc16e4800b0', :secret_key => '601d2664219e4886a059eeb251baad46')
	end

	describe "make get requests" do
		['award_summary', 'level_summary', 'good_summary', 'currency_type', 'currency'].each do |action|
			it "should make a #{action} request" do
				response = @big_door.send("get_#{action}")
				p response.parsed_response
				response.code.should eql(200)
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
			@users = BigDoor::User.all
			@users.each do |user|
				user.class.should eql(BigDoor::User)
			end
		end
	end
end
