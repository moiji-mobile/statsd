Class {
	#name : #ConfigurationOfStatsDClient,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfStatsDClient
}

{ #category : #'development support' }
ConfigurationOfStatsDClient class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfStatsDClient class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfStatsDClient class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfStatsDClient class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfStatsDClient class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfStatsDClient class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfStatsDClient class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfStatsDClient class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfStatsDClient class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfStatsDClient class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfStatsDClient >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/hfreyther2/StatsD/main/'.
		spec package: #StatsDClient. ].

]

{ #category : #accessing }
ConfigurationOfStatsDClient >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfStatsDClient >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.1-baseline'.

]

{ #category : #accessing }
ConfigurationOfStatsDClient >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfStatsDClient >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '5'.

]

{ #category : #versions }
ConfigurationOfStatsDClient >> version1: spec [
	<version: '1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1'.
		spec author: 'HolgerHansPeterFreyther'.
		spec timestamp: '9/20/2015 11:35'.
		spec package: #StatsDClient with: 'StatsDClient-HolgerHansPeterFreyther.3'. ].

]

{ #category : #versions }
ConfigurationOfStatsDClient >> version2: spec [
	<version: '2' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2'.
		spec author: 'HolgerHansPeterFreyther'.
		spec timestamp: '9/20/2015 15:29'.
		spec package: #StatsDClient with: 'StatsDClient-HolgerHansPeterFreyther.5'. ].

]

{ #category : #versions }
ConfigurationOfStatsDClient >> version3: spec [
	<version: '3' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3'.
		spec author: 'HolgerHansPeterFreyther'.
		spec timestamp: '10/9/2015 20:45'.
		spec package: #StatsDClient with: 'StatsDClient-HolgerHansPeterFreyther.6'. ].

]

{ #category : #versions }
ConfigurationOfStatsDClient >> version4: spec [
	<version: '4' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 4'.
		spec author: 'HolgerHansPeterFreyther'.
		spec timestamp: '9/28/2016 17:09'.
		spec package: #StatsDClient with: 'StatsDClient-HolgerHansPeterFreyther.7'. ].

]

{ #category : #versions }
ConfigurationOfStatsDClient >> version5: spec [
	<version: '5' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 5'.
		spec author: 'HolgerHansPeterFreyther'.
		spec timestamp: '9/22/2019 19:28'.
		spec package: #StatsDClient with: 'StatsDClient-HolgerHansPeterFreyther.8'. ].

]
