Class {
	#name : #ToMiniBrowserCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #PackagingExample
}

{ #category : #accessing }
ToMiniBrowserCommandLineHandler class >> commandName [

	^ 'toMiniBrowser'
]

{ #category : #activation }
ToMiniBrowserCommandLineHandler >> activate [

	| space |

	OSWindowDriver current startUp: true.
	EmbeddedSupport errorHandler: ESSDLMessageErrorHandler new.

	space := ToMiniBrowser open.
	space when: BlSpaceClosedEvent do: [ :e | Smalltalk snapshot: false andQuit: true ]
]
