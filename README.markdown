# TextMate bundle for Objective-C (iPhone)

There already exists a huge bundle for Objective-C and another for developing outside of Xcode. But the Objective-C bundle is also the Cocoa bundle. With the iPhone SDK, it has a different suite of classes, protocols etc.

Ultimately this bundle will provide access to the iPhone SDK classes and protocols. Its in its infancy, and since the NDA hasn't been lifted you shouldn't be reading this I guess.

## Features

* Protocol method stubs - never need remember what methods are required for your class to be a delegate of UITableView again, just select UITableViewDelegate and it spews out all the required and optional methods as ready-to-use stubs. (⌃⌥⌘P)

## Installation

To install via Git:

		cd ~/"Library/Application Support/TextMate/Bundles/"
		git clone git://github.com/drnic/objective-c-iphone-tmbundle.git "Objective-C iPhone.tmbundle"
		osascript -e 'tell app "TextMate" to reload bundles'

Source can be viewed or forked via GitHub: [http://github.com/drnic/objective-c-iphone-tmbundle/tree/master](http://github.com/drnic/objective-c-iphone-tmbundle/tree/master)
