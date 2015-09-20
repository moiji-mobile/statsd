"
I am a UDP client for the statsdD protocol

Set the destination hostname/port and then call start. Use the normal API for the rest of it.
"
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
