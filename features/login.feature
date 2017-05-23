Feature: login
	To use the web site, login

	Scenario: not logged in
	Given I am not logged in
	When I visit the site
	Then I should see "Login"

	Scenario: logging in with invalid id
	Given I am not logged in
	When I enter an invalid user name and password
	Then I should see "Login is not valid"
	
	Scenario: successful login
	Given I am the registered user JohnDoe
	And I am not logged in
	And I am on the login page
	When I login with valid credentials
	Then  I should see "Login successful!"
