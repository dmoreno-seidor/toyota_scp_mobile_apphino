import UIKit
import Flutter
import FBSDKCoreKit
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    GMSServices.provideAPIKey("AIzaSyCNr-ye4-LBTGAaVFtrfaRjtIS124XDWzI")
    ApplicationDelegate.shared.application(
        application,
        didFinishLaunchingWithOptions: launchOptions
    )
    
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
//    @available(iOS 9.0, *)
    override func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
    -> Bool {
       ApplicationDelegate.shared.application(
         application,
         open: url,
         sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
         annotation: options[UIApplication.OpenURLOptionsKey.annotation]
     )
    }
}


// import UIKit
// import Flutter
// import FBSDKLoginKit
// import FBSDKCoreKit
// import GoogleMaps

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
// override func application(
// _ application: UIApplication,
// didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
// ) -> Bool {
//     ApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
// // GMSServices provideAPIKey:@"AIzaSyCNr-ye4-LBTGAaVFtrfaRjtIS124XDWzI"
// GMSServices.provideAPIKey("AIzaSyCNr-ye4-LBTGAaVFtrfaRjtIS124XDWzI")
// GeneratedPluginRegistrant.register(with: self)
// return super.application(application, didFinishLaunchingWithOptions: launchOptions)
// }
// @available(iOS 9.0, *)
// override func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
// -> Bool {
// return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?,annotation: options[UIApplication.OpenURLOptionsKey.annotation])
// }

// // para iOS menor a 9.0
// override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
// return FBSDKApplicationDelegate.sharedInstance().application(application,open: url as URL?,sourceApplication: sourceApplication,annotation: annotation)
// }
// }


