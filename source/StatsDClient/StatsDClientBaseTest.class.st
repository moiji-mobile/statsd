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

{ #category : #'set up' }
StatsDClientBaseTest >> setUp [
	client := StatsDClientBase new.
]

{ #category : #tests }
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

{ #category : #'test Tags' }
StatsDClientBaseTest >> testFormatWithTags [
	"Adding tags to the statistics generation"

	| dico |
	dico := Dictionary new.
	dico at: 'key1' put: 1.
	dico at: 'key2' put: 2.5.
	dico at: 'key3' put: 'string3'.

	"counter"
	self
		assert:
			(client
				formatCounter: 'counter'
				value: 1
				rate: 1
				withTags: dico)
		equals: 'counter:1|c|#key1:1,key2:2.5,key3:string3'.
	self
		assert:
			(client
				formatCounter: 'counter'
				value: 1
				rate: 0.9
				withTags: dico)
		equals: 'counter:1|c|@0.9|#key1:1,key2:2.5,key3:string3'.

	"gauge"
	dico := Dictionary new.
	dico at: 'key5' put: 4.3.
	self
		assert:
			(client
				formatGauge: 'gauge'
				value: 99
				rate: 1
				withTags: dico)
		equals: 'gauge:99|g|#key5:4.3'.
	self
		assert:
			(client
				formatGauge: 'gauge'
				value: '+1'
				rate: 0.9
				withTags: dico)
		equals: 'gauge:+1|g|@0.9|#key5:4.3'.

	"set"
	self assert: (client formatSet: 'set' value: 1 withTags: dico) equals: 'set:1|s|#key5:4.3'.
	self
		assert:
			(client
				formatSet: 'set'
				value: 1
				rate: 0.9
				withTags: dico)
		equals: 'set:1|s|@0.9|#key5:4.3'.

	"timer"
	dico := Dictionary new.
	dico at: 'key6' put: 'string2'.
	self assert: (client formatTimer: 'timer' value: 1 withTags: dico) equals: 'timer:1|ms|#key6:string2'.
	self
		assert:
			(client
				formatTimer: 'timer'
				value: 1
				rate: 0.9
				withTags: dico)
		equals: 'timer:1|ms|@0.9|#key6:string2'
]
