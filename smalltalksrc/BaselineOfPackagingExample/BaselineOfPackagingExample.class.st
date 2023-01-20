Class {
	#name : #BaselineOfPackagingExample,
	#superclass : #BaselineOf,
	#category : #BaselineOfPackagingExample
}

{ #category : #baselines }
BaselineOfPackagingExample >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		spec 
			baseline: 'Toplo' 
			with: [ spec repository: 'github://plantec/Toplo/src'].

		spec 
			baseline: 'EmbeddedSupport' 
			with: [ spec repository: 'github://tesonep/pharo-vm-embedded-example:pharo-11'].
		
		spec package: 'PackagingExample' with: [ spec requires: #('EmbeddedSupport' 'Toplo') ].

		spec group: 'default' 
			with: #( 'PackagingExample' ).
	]

]
