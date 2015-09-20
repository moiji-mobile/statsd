Class {
	#name : #UDPStatsDClient,
	#superclass : #StatsDClientBase,
	#instVars : [
		'socket',
		'address',
		'port'
	],
	#category : #StatsDClient
}

{ #category : #'as yet unclassified' }
UDPStatsDClient >> hostname: aHostname [
	address := NetNameResolver addressForName: aHostname.
]

{ #category : #'as yet unclassified' }
UDPStatsDClient >> port: aPort [
	port := aPort.
]

{ #category : #'as yet unclassified' }
UDPStatsDClient >> sendData: aMsg [
	socket sendUDPData: aMsg toHost: address port: port
]

{ #category : #'as yet unclassified' }
UDPStatsDClient >> start [
	socket := Socket newUDP.
]
