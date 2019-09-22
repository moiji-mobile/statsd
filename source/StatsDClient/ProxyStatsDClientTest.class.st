"
A ProxyStatsDClientTest is a test class for testing the behavior of ProxyStatsDClient
"
Class {
	#name : #ProxyStatsDClientTest,
	#superclass : #TestCase,
	#category : #'StatsDClient-Tests'
}

{ #category : #tests }
ProxyStatsDClientTest >> testAllClientsReceive_success [
	| clientA clientB statsd |
	
	clientA := QueuedStatsDClient new.
	clientB := QueuedStatsDClient new.
	statsd := ProxyStatsDClient new
		addClient: clientA;
		addClient: clientB;
		yourself.

	statsd decrement: 'dec1' rate: 1.
	self assert: (clientA instVarNamed: #queued) first equals: 'dec1:-1|c'.
	self assert: (clientB instVarNamed: #queued) first equals: 'dec1:-1|c'.
]
