"
I am the baseclass and I know how to format things.
"
Class {
	#name : #StatsDClientBase,
	#superclass : #Object,
	#instVars : [
		'rateRandom',
		'prefix'
	],
	#category : #StatsDClient
}

{ #category : #api }
StatsDClientBase >> decrement: aName rate: aRate [

	(self forwardEvent: aRate) ifTrue: [
		self sendData: (self formatCounter: aName value: -1 rate: aRate)]
]

{ #category : #format }
StatsDClientBase >> format: aName value: aValue rate: aRate type: aType [ 
	^String streamContents: [:str |
		str
			nextPutAll: prefix;
			nextPutAll: aName; nextPut: $:;
			nextPutAll: aValue; nextPut: $|;
			nextPutAll: aType.
		aRate < 1 ifTrue: [
			"Formating a float is expensive. So maybe have a look for standard values"
			str
				nextPut: $@;
				nextPutAll: aRate asString.
		]]
]

{ #category : #format }
StatsDClientBase >> formatCounter: aCounterName value: aValue [
	^self formatCounter: aCounterName value: aValue rate: 1
]

{ #category : #format }
StatsDClientBase >> formatCounter: aCounterName value: aValue rate: aRate [
	^self format: aCounterName value: aValue asString rate: aRate type: 'c'
]

{ #category : #format }
StatsDClientBase >> formatGauge: aGaugeName value: aValue [
	^self formatGauge: aGaugeName value: aValue rate: 1
]

{ #category : #format }
StatsDClientBase >> formatGauge: aGaugeName value: aValue rate: aRate [
	^self format: aGaugeName value: aValue asString rate: aRate type: 'g'
]

{ #category : #format }
StatsDClientBase >> formatSet: aSetName value: aValue [
	^self formatSet: aSetName value: aValue rate: 1
]

{ #category : #format }
StatsDClientBase >> formatSet: aSetName value: aValue rate: aRate [
	^self format: aSetName value: aValue asString rate: aRate type: 's'
]

{ #category : #format }
StatsDClientBase >> formatTimer: aTimerName value: aValue [
	^self formatTimer: aTimerName value: aValue rate: 1
]

{ #category : #format }
StatsDClientBase >> formatTimer: aTimerName value: aValue rate: aRate [
	^self format: aTimerName value: aValue asString rate: aRate type: 'ms'
]

{ #category : #'as yet unclassified' }
StatsDClientBase >> forwardEvent: aRate [
	^aRate < 1
		ifTrue: [rateRandom next <= aRate]
		ifFalse: [true]
]

{ #category : #api }
StatsDClientBase >> gauge: aName value: aValue rate: aRate [

	(self forwardEvent: aRate) ifTrue: [
		self sendData: (self formatGauge: aName value: aValue rate: aRate)]
]

{ #category : #api }
StatsDClientBase >> increment: aName rate: aRate [

	(self forwardEvent: aRate) ifTrue: [
		self sendData: (self formatCounter: aName value: 1 rate: aRate)]
]

{ #category : #'as yet unclassified' }
StatsDClientBase >> initialize [
	super initialize.
	rateRandom := Random new.
	prefix := ''.
]

{ #category : #api }
StatsDClientBase >> prefix: aPrefix [
]

{ #category : #'as yet unclassified' }
StatsDClientBase >> sendData: aMsg [
	self subclassResponsibility
]

{ #category : #api }
StatsDClientBase >> set: aName value: aValue rate: aRate [

	(self forwardEvent: aRate) ifTrue: [
		self sendData: (self formatSet: aName value: aValue rate: aRate)]
]

{ #category : #api }
StatsDClientBase >> time: aName block: aBlock rate: aRate [
	| time |
	"We could use >>#value here but then sampled/unsampled would behave
	differently"
	time := aBlock timeToRun asMilliSeconds.
	(self forwardEvent: aRate) ifTrue: [
		self sendData: (self formatTimer: aName value: time rate: aRate)]
]
