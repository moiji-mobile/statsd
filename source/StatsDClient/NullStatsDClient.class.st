"
I do no work.

""2021/05/20""
The instance variable atomicContent has bee added in order to use Unittests (and to test contents of data send to a NulStatsDClient object) outside of StatsDClientTest scope


"
Class {
	#name : #NullStatsDClient,
	#superclass : #StatsDClientBase,
	#instVars : [
		'atomicContent'
	],
	#category : #StatsDClient
}

{ #category : #'accessing-initialize' }
NullStatsDClient >> atomicContent [
	^ atomicContent
]

{ #category : #'as yet unclassified' }
NullStatsDClient >> decrement: aName rate: aRate [
]

{ #category : #Tags }
NullStatsDClient >> format: aName value: aValue rate: aRate type: aType [
	"We store the string in the temporary buffer atomicContent"

	atomicContent := super
		format: aName
		value: aValue
		rate: aRate
		type: aType.
	^ atomicContent
]

{ #category : #Tags }
NullStatsDClient >> format: aName value: aValue rate: aRate type: aType withTags: aDictionary [
	"We store the string in the temporary buffer atomicContent"

	atomicContent := super
		format: aName
		value: aValue
		rate: aRate
		type: aType
		withTags: aDictionary.
	^ atomicContent
]

{ #category : #'as yet unclassified' }
NullStatsDClient >> gauge: aName value: aValue rate: aRate [
]

{ #category : #api }
NullStatsDClient >> increment: aName by: aCount rate: aRate [
	^ self formatCounter: aName value: aCount rate: aRate
]

{ #category : #Tags }
NullStatsDClient >> increment: aName by: aCount rate: aRate withTags: aDictionary [
	^ self
		formatCounter: aName
		value: aCount
		rate: aRate
		withTags: aDictionary
]

{ #category : #'accessing-initialize' }
NullStatsDClient >> initialize [
	super initialize.
	atomicContent := String new
]

{ #category : #'as yet unclassified' }
NullStatsDClient >> set: aName value: aValue rate: aRate [
]

{ #category : #'as yet unclassified' }
NullStatsDClient >> time: aName rate: aRate block: aBlock [
	aBlock value
]
