Given /^I have API credentials$/ do
	@big_door = BigDoor::Base.new(:app_key => '0deee7386916481199b5cbc16e4800b0', :secret_key => '601d2664219e4886a059eeb251baad46')
end

When /^I make a request to for "([^"]*)"$/ do |arg1|
	@response = @big_door.get_award_summary
end

Then /^I should receive a "([^"]*)" response code$/ do |response_code|
	puts @response
	@response.code.should eql(response_code.to_i)
end

Then /^the response should be "([^"]*)"$/ do |arg1|
	@response.parsed_response.should eql([[], {}])
end


When /^I create a user named "([^"]*)"$/ do |name|
	@response = @big_door.post_end_user(:end_user_login => name)
	@response.code.should eql(201)
end

Then /^I should have "([^"]*)" new user$/ do |num|
	response = @big_door.get_end_user
	response.parsed_response
end
