Extension { #name : #ToMiniBrowser }

{ #category : #'*PackagingExample' }
ToMiniBrowser >> initialize [

	| codeMenu classesPane classesButtonPane sideToggle boomButton |
	super initialize.
	listsPane := ToHorizontalPane new margin: (BlInsets top: 5 bottom: 5).
	listsPane layout: (BlLinearLayout horizontal cellSpacing: 5).
	listsPane matchParent.
	
	mainPane := ToVerticalPane new.
	mainPane matchParent.

	packages := ToList new nodeFactory: [ :pkg | 
		            ToLabeledNode new
			            labelText: pkg name;
			            hMatchParent ].
	"packages hasFixedSize: true."
	"packages selectionStrategy beWithoutSelection."
	packages
		when: ToSelectionChangedEvent
		do: [ :event | self packageSelectionChangedEvent: event ].
	packages list addAll:
		(RPackage organizer packages asSortedCollection: [ :p1 :p2 | 
			 p1 name < p2 name ]).

	classes := ToList new nodeFactory: [ :cls | 
		           ToLabeledNode new
			           labelText: cls name;
			           hMatchParent ].
	classes
		when: ToSelectionChangedEvent
		do: [ :event | self classSelectionChangedEvent: event ].
	classes list whenRemoveChangeDo: [ protocols list removeAll ].
	classesPane := ToVerticalPane new matchParent.
	classesPane addChild: classes.
	classesButtonPane := ToHorizontalPane new
		                     hMatchParent;
		                     vFitContent.
	classesButtonPane addChild: (sideToggle := ToToggleButton new
			               label: (ToLabel text: 'Class side');
			               beLabelFirst;
								
			               margin: (BlInsets top: 5);
			               padding: (BlInsets all: 0)).
	classesButtonPane addChild: (
			(boomButton := ToButton new) 
				labelText: 'Boom!'; 
				margin: (BlInsets top: 5 left: 5);
			   padding: (BlInsets all: 0);
				whenClickedDo: [ self error: 'Boom!' ]
			   yourself).
	sideToggle layout cellSpacing: 5.
	classesPane addChild: classesButtonPane.

	sideToggle check: self classSide.
	sideToggle whenCheckedDo: [ 
		classes dispatchSelectionChangedAfter: [ classSide := true ] ].
	sideToggle whenUncheckedDo: [ 
		classes dispatchSelectionChangedAfter: [ classSide := false ] ].

	protocols := ToList new nodeFactory: [ :assoc | 
		             ToLabeledNode new
			             labelText: assoc value name;
			             hMatchParent ].

	protocols
		when: ToSelectionChangedEvent
		do: [ :event | self protocolSelectionChangedEvent: event ].
	protocols list whenRemoveChangeDo: [ selectors list removeAll ].

	selectors := ToList new nodeFactory: [ :assoc | 
		             ToLabeledNode new
			             labelText: assoc value asString;
			             hMatchParent ].
	selectors
		when: ToSelectionChangedEvent
		do: [ :event | self selectorSelectionChangedEvent: event ].
	selectors list whenRemoveChangeDo: [ self clearCodeInEditor ].
	"selectors hasFixedSize: true."
	
	codeModel := ToAlbumModel new withRowNumbers.
	codeModel styler: BlRBTextStyler new.
	codePane := codeModel onWidget margin: (BlInsets all: 5).

	codeMenu := ToContextMenu new globalColumnWidth: 0.
	codeMenu addItem: (ToButtonMenuItem new labelText: 'Accept').
	codePane contextMenu: codeMenu.

	packages withRowNumbers.
	classes withRowNumbers.
	protocols withRowNumbers.
	selectors withRowNumbers.

	listsPane addChild: packages.
	listsPane addChild: classesPane.
	listsPane addChild: protocols.
	listsPane addChild: selectors.

	mainPane addChild: listsPane.
	mainPane addChild: codePane
]

{ #category : #'*PackagingExample' }
ToMiniBrowser >> open [

	^ mainPane openInOBlSpace title: 'Mini browser'
]

{ #category : #'*PackagingExample' }
ToMiniBrowser class >> open [
	<script>
	^ self new open
]
