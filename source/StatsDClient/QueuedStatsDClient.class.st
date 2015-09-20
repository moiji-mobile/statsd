"
I can be used to queue/delay. Currently I require a flush.

TODO: Separate network from format.. here.. 
"
Class {
	#name : #QueuedStatsDClient,
	#superclass : #StatsDClientBase,
	#instVars : [
		'semaphore',
		'queued',
		'client'
	],
	#category : #StatsDClient
}

{ #category : #'as yet unclassified' }
QueuedStatsDClient >> client: aRealClient [
	self flag: #todo. "We need to separate network from the client"
	client := aRealClient
]

{ #category : #'as yet unclassified' }
QueuedStatsDClient >> flush [
	| data |
	"Swap all queued messages"
	data := semaphore critical: [ | tmp |
				tmp := queued.
				queued := OrderedCollection new.
				tmp].

	"Send off the data that was queued. Don't care
	about MTU size or such..."
	data isEmpty ifFalse: [
		client sendData: (Character lf join: data)]
	
]

{ #category : #'as yet unclassified' }
QueuedStatsDClient >> initialize [
	super initialize.
	semaphore := Semaphore forMutualExclusion.
	queued := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
QueuedStatsDClient >> sendData: aMsg [
	semaphore critical: [ queued add: aMsg ]
]
