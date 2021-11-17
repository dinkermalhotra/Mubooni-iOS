import UIKit
import FBSDKCoreKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Manage IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = UIColor.black
        
        DispatchQueue.global(qos: .background).async {
            self.fetchUserRoles()
            self.fetchSpecilizations()
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let fbUrl = ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        let googleUrl = GIDSignIn.sharedInstance.handle(url)
        
        if Auth.auth().canHandle(url) {
            return true
        }
        
        if fbUrl {
            return true
        }
        
        if googleUrl {
            return true
        }
        
        return false
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

// MARK: - API CALL
extension AppDelegate {
    func fetchUserRoles() {
        WSManager.wsCallUserRole { isSuccess, message, userRoles in
            if isSuccess {
                Singleton.userRoles = userRoles
            }
        }
    }
    
    func fetchSpecilizations() {
        WSManager.wsCallSpecilizations { isSuccess, message, specilizations in
            if isSuccess {
                Singleton.specilizations = specilizations
            }
        }
    }
}
