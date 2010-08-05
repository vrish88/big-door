Feature: Provide API access to Big Door media
	As a developer
	I want to access Big Door media's API

	Scenario: Sending a request to get award summary
		Given I have API credentials
		When I make a request to for "award_summary"
		Then I should receive a "200" response code
		And the response should be ""
		
	Scenario: Creating an end user
		Given I have API credentials
		When I create a user named "testers"
		Then I should receive a "end_user" object
		
	Scenario: Checking the currency balance for a user
	  Given I have API credentials
		And I have a user
	  When I check the user's "currency_balance"
	  Then I should receive a "200" response code
		And I should receive a "currency" object
