
Feature: Basic

# The secrects can be used in the payload with the following syntax #(mysecretname)
Background:
* def sshkey = karate.properties['sshkey']


Scenario: get request

	Given url karate.properties['testURL']

	And path '/'
	And header Direktiv-ActionID = 'development'
	And header Direktiv-TempDir = '/tmp'
	And request
	"""
	{
		"commands": [
		{
			"command": "ls -la",
			"silent": true,
			"print": false,
		}
		]
	}
	"""
	When method POST
	Then status 200
	And match $ ==
	"""
	{
	"scp": [
	{
		"result": "#notnull",
		"success": true
	}
	]
	}
	"""
	