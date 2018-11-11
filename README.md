# iMovieApp
An sample app used to consume some endpoints from 'The Movie Database API'

Notes regarding approaches:
* Used 2 third-party libraries for reactive programming (RxSwift, RxCocoa)
* Code: Swift
* Views use AutoLayout
* Views are created programmatically, same for ViewControllers
* On movie list, search or ’now playing’ have paging with infinite scrolling
* Cached images while getting them to avoid consuming network when scrolling back
* Images are downloaded asynchronously
* Created a custom AsyncImageView to avoid using Apple’s CA decode func on mainThread (for performance)
* Written unit tests
* App UI should look exactly the same as in the screenshots
* Autocompletion search is done using debounce to do server requests only when needed.
* Please also check the comments inside the app
* Didn’t architect it more due to the time limitation
* Please note that MovieAPI is not returning data for some images, used as a placeholder a spinner and background gray
* Don’t forget to run ‘pod install’ before trying the project
