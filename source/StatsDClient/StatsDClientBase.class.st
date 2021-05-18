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
	^self increment: aName by: -1 rate: aRate.
]

{ #category : #'as yet unclassified' }
StatsDClientBase >> flush [
	"Do nothing here. Part of the 'pipeline' part"
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

{ #category : #Tags }
StatsDClientBase >> format: aName value: aValue rate: aRate type: aType withTags: aDictionary [
	"Adding tags to the statistics generation
	Argument added : aDictionary.
	Tags are expressed under a key-value form"

	| keys |
	^ String
		streamContents: [ :str | 
			str
				nextPutAll: prefix;
				nextPutAll: aName;
				nextPut: $:;
				nextPutAll: aValue;
				nextPut: $|;
				nextPutAll: aType.
			aRate < 1
				ifTrue: [ "Formating a float is expensive. So maybe have a look for standard values"
					str
						nextPut: $|;
						nextPut: $@;
						nextPutAll: aRate asString ].
			aDictionary isEmpty
				ifFalse: [ str
						nextPut: $|;
						nextPut: $# ].
			1 to: (keys := aDictionary keys) size do: [ :i | 
				| key |
				i = 1
					ifFalse: [ str nextPut: $, ].
				key := keys at: i.
				str nextPutAll: key.
				str nextPut: $:.
				str nextPutAll: (aDictionary at: key) asString ] ]
]

{ #category : #format }
StatsDClientBase >> formatCounter: aCounterName value: aValue [
	^self formatCounter: aCounterName value: aValue rate: 1
]

{ #category : #format }
StatsDClientBase >> formatCounter: aCounterName value: aValue rate: aRate [
	^self format: aCounterName value: aValue asString rate: aRate type: 'c'
]

{ #category : #Tags }
StatsDClientBase >> formatCounter: aCounterName value: aValue rate: aRate withTags: aDictionary [
	"Adding tags to the statistics generation
	Argument added : aDictionary.
	Tags are expressed under a key-value form"

	^ self
		format: aCounterName
		value: aValue asString
		rate: aRate
		type: 'c'
		withTags: aDictionary
]

{ #category : #Tags }
StatsDClientBase >> formatCounter: aCounterName value: aValue withTags: aDictionary [
	"Adding tags to the statistics generation
	Argument added : aDictionary.
	Tags are expressed under a key-value form"

	^ self
		formatCounter: aCounterName
		value: aValue
		rate: 1
		withTags: aDictionary
]

{ #category : #format }
StatsDClientBase >> formatGauge: aGaugeName value: aValue [
	^self formatGauge: aGaugeName value: aValue rate: 1
]

{ #category : #format }
StatsDClientBase >> formatGauge: aGaugeName value: aValue rate: aRate [
	^self format: aGaugeName value: aValue asString rate: aRate type: 'g'
]

{ #category : #Tags }
StatsDClientBase >> formatGauge: aGaugeName value: aValue rate: aRate withTags: aDictionary [
	"Adding tags to the statistics generation
	Argument added : aDictionary.
	Tags are expressed under a key-value form"

	^ self
		format: aGaugeName
		value: aValue asString
		rate: aRate
		type: 'g'
		withTags: aDictionary
]

{ #category : #Tags }
StatsDClientBase >> formatGauge: aGaugeName value: aValue withTags: aDictionary [
	"Adding tags to the statistics generation
	Argument added : aDictionary.
	Tags are expressed under a key-value form"

	^ self
		formatGauge: aGaugeName
		value: aValue
		rate: 1
		withTags: aDictionary
]

{ #category : #format }
StatsDClientBase >> formatSet: aSetName value: aValue [
	^self formatSet: aSetName value: aValue rate: 1
]

{ #category : #format }
StatsDClientBase >> formatSet: aSetName value: aValue rate: aRate [
	^self format: aSetName value: aValue asString rate: aRate type: 's'
]

{ #category : #Tags }
StatsDClientBase >> formatSet: aSetName value: aValue rate: aRate withTags: aDictionary [
	"Adding tags to the statistics generation
	Argument added : aDictionary.
	Tags are expressed under a key-value form"

	^ self
		format: aSetName
		value: aValue asString
		rate: aRate
		type: 's'
		withTags: aDictionary
]

{ #category : #Tags }
StatsDClientBase >> formatSet: aSetName value: aValue withTags: aDictionary [
	"Adding tags to the statistics generation
	Argument added : aDictionary.
	Tags are expressed under a key-value form"

	^ self
		formatSet: aSetName
		value: aValue
		rate: 1
		withTags: aDictionary
]

{ #category : #format }
StatsDClientBase >> formatTimer: aTimerName value: aValue [
	^self formatTimer: aTimerName value: aValue rate: 1
]

{ #category : #format }
StatsDClientBase >> formatTimer: aTimerName value: aValue rate: aRate [
	^self format: aTimerName value: aValue asString rate: aRate type: 'ms'
]

{ #category : #Tags }
StatsDClientBase >> formatTimer: aTimerName value: aValue rate: aRate withTags: aDictionary [
	"Adding tags to the statistics generation
	Argument added : aDictionary.
	Tags are expressed under a key-value form"

	^ self
		format: aTimerName
		value: aValue asString
		rate: aRate
		type: 'ms'
		withTags: aDictionary
]

{ #category : #Tags }
StatsDClientBase >> formatTimer: aTimerName value: aValue withTags: aDictionary [
	"Adding tags to the statistics generation
	Argument added : aDictionary.
	Tags are expressed under a key-value form"

	^ self
		formatTimer: aTimerName
		value: aValue
		rate: 1
		withTags: aDictionary
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
StatsDClientBase >> increment: aName by: aCount rate: aRate [

	(self forwardEvent: aRate) ifTrue: [
		self sendData: (self formatCounter: aName value: aCount rate: aRate)]
]

{ #category : #api }
StatsDClientBase >> increment: aName by: aCount rate: aRate withTags: aDictionary [
	"Adding tags to the statistics generation
	Argument added : aDictionary.
	Tags are expressed under a key-value form"

	(self forwardEvent: aRate)
		ifTrue: [ self
				sendData:
					(self
						formatCounter: aName
						value: aCount
						rate: aRate
						withTags: aDictionary) ]
]

{ #category : #api }
StatsDClientBase >> increment: aName rate: aRate [
	^self increment: aName by: 1 rate: aRate.
]

{ #category : #api }
StatsDClientBase >> increment: aName rate: aRate withTags: aDictionary [
	"Adding tags to the statistics generation
	Argument added : aDictionary.
	Tags are expressed under a key-value form"

	^ self
		increment: aName
		by: 1
		rate: aRate
		withTags: aDictionary
]

{ #category : #'as yet unclassified' }
StatsDClientBase >> initialize [
	super initialize.
	rateRandom := Random new.
	prefix := ''.
]

{ #category : #api }
StatsDClientBase >> prefix: aPrefix [
	prefix := aPrefix
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
StatsDClientBase >> time: aName rate: aRate block: aBlock [
	|  initialMicroseconds |
	"We could use >>#value here but then sampled/unsampled would behave
	differently"
	[
		initialMicroseconds := Time microsecondClockValue.
		^aBlock value
	] ensure: [
		| time |
		time := (Time microsecondClockValue - initialMicroseconds) // 1e3.
		(self forwardEvent: aRate) ifTrue: [
			self sendData: (self formatTimer: aName value: time rate: aRate)]].
]
