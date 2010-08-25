# Givens
Given /^I have API credentials$/ do
	@big_door = BigDoor::Base.new(:app_key => '0deee7386916481199b5cbc16e4800b0', :secret_key => '601d2664219e4886a059eeb251baad46')
end

Given /^I have a user$/ do
	VCR.use_cassette('user/all', :record => :new_episodes) do
		@user = @big_door.get_end_user.first
	end
end

Given /^I have a "([^"]*)" named "([^"]*)"$/ do |action, name|
	debugger
	if action == "NamedTransaction"
		VCR.use_cassette("NamedTransaction/specific", :record => :new_episodes) do
			@transaction = BigDoor::NamedTransaction.find(:pub_title => name)
		end
	elsif action == 'NamedTransactionGroup'
		VCR.use_cassette("named_transaction_group/specific", :record => :new_episodes) do
			@grp_trans = BigDoor::NamedTransactionGroup.find(:pub_title__startswith => name)
		end
		debugger
		@grp_trans.should_not eql(nil)
	end
end

# Whens
When /^I make a request for "([^\"]*)"$/ do |arg1|
	VCR.use_cassette('award/award_summary', :record => :new_episodes) do
		@response = @big_door.get_award_summary
	end
end

When /^I create a user named "([^\"]*)"$/ do |name|
	VCR.use_cassette('user/new', :record => :new_episodes) do
		@response = BigDoor::User.find(name)
	end
	@response.class.should eql(BigDoor::User)
end

When /^I check the user's "([^\"]*)"$/ do |action| 
	VCR.use_cassette('user/all', :record => :new_episodes) do
		@response = @user.send action
	end
end

When /^I add "([^\"]*)" points to users's account$/ do |points|
	VCR.use_cassette('user/currency_balance', :record => :new_episodes) do
		# @old_points = @user.get_currency_balance(@currency)
	end

	VCR.use_cassette('user/add_points', :record => :new_episodes) do
		@user.add_points(@grp_trans, points.to_i)
	end
end

# Thens
Then /^I should have "([^\"]*)" new user$/ do |num|
	@response = @big_door.get_end_user
end

Then /^I should receive a "([^\"]*)" object$/ do |received_object|
	if @response.is_a? Array
		@response.first.class.should eql(received_object.constantize)
	else
		@response.class.should eql(eval(received_object))
	end
end

Then /^I should receive a "([^\"]*)" response code$/ do |response_code|
	@response.code.should eql(response_code.to_i)
end

Then /^the response should be "([^"]*)"$/ do |arg1|
	@response.should eql(eval(arg1))
end

Then /^their account should have "([^\"]*)" more points$/ do |arg1|\
  pending # express the regexp above with the code you wish you had
end
