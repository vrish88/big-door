require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'ruby-debug'

describe "BigDoor" do
	before do
		@big_door = BigDoor::Base.new(:app_key => '0deee7386916481199b5cbc16e4800b0', :secret_key => '601d2664219e4886a059eeb251baad46')
	end

	describe "make get requests" do
		['award_summary', 'level_summary', 'good_summary', 'currency_type', 'currency', "transaction_summary"].each do |action|
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
end
