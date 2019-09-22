"
I am a proxy/tee to allow to send one occurence to multiple endpoints.
"
Class {
	#name : #ProxyStatsDClient,
	#superclass : #StatsDClientBase,
	#instVars : [
		'clients'
	],
	#category : #StatsDClient
}

{ #category : #'as yet unclassified' }
ProxyStatsDClient >> addClient: aClient [ 
	clients add: aClient
]

{ #category : #initialization }
ProxyStatsDClient >> initialize [
	super initialize.
	clients := OrderedCollection new.
]

{ #category : #initialization }
ProxyStatsDClient >> sendData: aMsg [
	clients do: [:each |
		each sendData: aMsg].
]
