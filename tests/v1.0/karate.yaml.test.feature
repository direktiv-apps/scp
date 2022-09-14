
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
    "source": {
        "file": "/usr/local/bin/setup.sh"
    },
    "target": {
        "host": "ec2-52-207-249-40.compute-1.amazonaws.com",
        "user": "ubuntu",
        "identity": #(sshkey),
        "file": "/tmp/jensgerke"
    },
    "recursive": false,
    "verbose": true
	}
	"""
	When method POST
	Then status 200
	# And match $ ==
	# """
	# {
	# "scp": [
	# {
	# 	"result": "#notnull",
	# 	"success": true
	# }
	# ]
	# }
	# """
	