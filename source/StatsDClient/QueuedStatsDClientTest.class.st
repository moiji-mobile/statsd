"
A QueuedStatsDClientTest is a test class for testing the behavior of QueuedStatsDClient
"
Class {
	#name : #QueuedStatsDClientTest,
	#superclass : #TestCase,
	#instVars : [
		'statsd'
	],
	#category : #'StatsDClient-Tests'
}

{ #category : #'as yet unclassified' }
QueuedStatsDClientTest >> setUp [
	statsd := QueuedStatsDClient new.
]

{ #category : #'as yet unclassified' }
QueuedStatsDClientTest >> testCounterApi [
	| queued |

	statsd decrement: 'dec1' rate: 1.
	statsd increment: 'inc1' rate: 1.
	statsd increment: 'inc2' by: 10 rate: 1.
	statsd decrement: 'dec-noshow' rate: 0.
	statsd increment: 'inc-nowshow' rate: 0.

	queued := statsd instVarNamed: #queued.
	self assert: queued size equals: 3.
	self assert: (queued at: 1) equals: 'dec1:-1|c'.
	self assert: (queued at: 2) equals: 'inc1:1|c'.
	self assert: (queued at: 3) equals: 'inc2:10|c'.
]
