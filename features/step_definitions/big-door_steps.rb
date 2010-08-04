Given /^I have API credentials$/ do
	@big_door = BigDoor::Base.new(:app_key => '28d3da80bf36fad415ab57b3130c6cb6', :secret_key => 'B66F956ED83AE218612CB0FBAC2EF01C')
end

When /^I make a request to for "([^"]*)"$/ do |arg1|
	@response = @big_door.get_award_summary
end

Then /^I should receive a "([^"]*)" response code$/ do |arg1|
	puts @response
	@response.code.should eql(200)
end

Then /^the response should be "([^"]*)"$/ do |arg1|
	@response.parsed_response.should eql([[], {}])
end
