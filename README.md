
##PullToMakeFlight

Custom animated pull-to-refresh that can be easily added to UIScrollView

[![Yalantis](https://raw.githubusercontent.com/Yalantis/PullToMakeFlight/master/PullToMakeFlightDemo/Resources/badge_dark.png)](https://yalantis.com/?utm_source=github)

<img src="https://raw.githubusercontent.com/Yalantis/PullToMakeFlight/master/PullToMakeFlightDemo/Resources/tours-pull-airplane.gif" />

##Requirements
- iOS 8.0+
- Xcode 7
- Swift 2

##Installing with [CocoaPods](https://cocoapods.org)

```ruby
use_frameworks!
pod 'PullToMakeFlight', '~> 1.0'
```

##Usage

At first, import PullToMakeFlight framework:

```swift
import PullToMakeFlight
```

Create refresher:


```swift
let refresher = PullToMakeFlight()
```

Add refresher to your UIScrollView subclass and provide action block:

```swift
tableView.addPullToRefresh(refresher, action: {
     // action to be performed (pull data from some source)
})
```

After the action is completed and you want to hide the refresher:

```swift
tableView.endRefreshing()
```
 
You can also start refreshing programmatically:

```swift
tableView.startRefreshing()
```

Component was implemented based on [customizable pull-to-refresh](https://github.com/Yalantis/PullToRefresh)

## License

	The MIT License (MIT)

	Copyright © 2015 Yalantis

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
