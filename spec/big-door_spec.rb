require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "BigDoor" do
	before do
		@big_door = BigDoor::Base.new(:app_key => '0deee7386916481199b5cbc16e4800b0', :secret_key => '601d2664219e4886a059eeb251baad46')
	end

	describe "make get requests" do
		['award_summary', 'level_summary', 'good_summary', 'currency_type', 'currency'].each do |action|
			it "should make a #{action} request" do
				response = @big_door.send("get_#{action}")
				response.code.should eql(200)
			end
		end
	end
end
