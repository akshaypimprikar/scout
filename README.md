# scout

Scout is an app that shows you  a list of top places around your current location.

Login using your Facebook account, the tab bar app shows you your current location on the map in the first tab.

Second tab shows a table view of a list of top places.

Tapping on a place takes you to the place details page.

Open the Scout.xcworkspace
Run 'pod install' before running the Xcode project.
If you are running the app on the simulator please make sure to set the device location (Debug --> Location) before starting the app.

## extras

Alamofire, Facebook and Google Places SDKs are imported via Cocoapods.

The images are lazy loaded using AlamofireImage

Pull to refresh has also been implemented on the table view.