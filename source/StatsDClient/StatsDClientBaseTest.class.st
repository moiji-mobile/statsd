"
A StatsDClientBaseTest is a test class for testing the behavior of StatsDClientBase
"
Class {
	#name : #StatsDClientBaseTest,
	#superclass : #TestCase,
	#instVars : [
		'client'
	],
	#category : #'StatsDClient-Tests'
}

{ #category : #'as yet unclassified' }
StatsDClientBaseTest >> setUp [
	client := StatsDClientBase new.
]

{ #category : #'as yet unclassified' }
StatsDClientBaseTest >> testFormat [

	self assert: (client formatCounter: 'counter' value: 1) equals: 'counter:1|c'.
	self assert: (client formatCounter: 'counter' value: 1 rate: 0.9) equals: 'counter:1|c@0.9'.

	self assert: (client formatGauge: 'gauge' value: 99) equals: 'gauge:99|g'.
	self assert: (client formatGauge: 'gauge' value: '+1' rate: 0.9) equals: 'gauge:+1|g@0.9'.

	self assert: (client formatSet: 'set' value: 1) equals: 'set:1|s'.
	self assert: (client formatSet: 'set' value: 1 rate: 0.9) equals: 'set:1|s@0.9'.

	self assert: (client formatTimer: 'timer' value: 1) equals: 'timer:1|ms'.
	self assert: (client formatTimer: 'timer' value: 1 rate: 0.9) equals: 'timer:1|ms@0.9'.

]
