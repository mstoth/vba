Feature: groups
	In order to manage my groups
	I need to do CRUD operations
	
	
	Scenario: Creating a new group
	Given I have 0 groups
	When I create a group
	Then I have 1 group
	
	