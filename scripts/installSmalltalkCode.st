path := CommandLineArguments default commandLineArguments last.
Metacello new
  baseline: 'PackagingExample';
	repository: 'gitlocal://' , path , '/smalltalksrc';
	load