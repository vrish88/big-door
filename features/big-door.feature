Feature: Provide API access to Big Door media
	As a developer
	I want to access Big Door media's API

	Scenario: Sending a request to get award summary
		Given I have API credentials
		When I make a request for "award_summary"
		Then the response should be "[]"
		
	Scenario: Creating an end user
		Given I have API credentials
		When I create a user named "testers"
		Then I should receive a "BigDoor::User" object
		
	Scenario: Checking the currency balance for a user
	  Given I have API credentials
		And I have a user
	  When I check the user's "currency_balances"
		Then the response should be "[]"
		
	Scenario: Adding points to a user's account
		Given I have API credentials
		And I have a user
		And I have a "NamedTransactionGroup" named "Not so basic"
		When I add "30" points to users's account
		Then their account should have "30" more points
