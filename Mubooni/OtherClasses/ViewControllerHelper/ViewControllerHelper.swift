struct ViewControllerIdentifiers {
    
    static let IntroScreensViewController   = "IntroScreensViewController"
    static let LoginViewController          = "LoginViewController"
    static let MainViewController           = "MainViewController"
    static let SignInViewController         = "SignInViewController"
    static let SignupViewController         = "SignupViewController"
}

import UIKit

enum ViewControllerType {
    case IntroScreensViewController
    case LoginViewController
    case MainViewController
    case SignInViewController
    case SignupViewController
}

class ViewControllerHelper: NSObject {
    
    // This is used to retirve view controller and intents to reutilize the common code.
    
    class func getViewController(ofType viewControllerType: ViewControllerType) -> UIViewController {
        var viewController: UIViewController?
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Login Storyboard
        if viewControllerType == .IntroScreensViewController {
            viewController = loginStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.IntroScreensViewController) as! IntroScreensViewController
        }
        else if viewControllerType == .LoginViewController {
            viewController = loginStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.LoginViewController) as! LoginViewController
        }
        else if viewControllerType == .MainViewController {
            viewController = loginStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.MainViewController) as! MainViewController
        }
        else if viewControllerType == .SignInViewController {
            viewController = loginStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.SignInViewController) as! SignInViewController
        }
        else if viewControllerType == .SignupViewController {
            viewController = loginStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.SignupViewController) as! SignupViewController
        }
        // Main Storyboard
//        else if viewControllerType == .LabelChangeViewController {
//            viewController = dashboardStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.LabelChangeViewController) as! LabelChangeViewController
//        }
        else {
            print("Unknown view controller type")
        }
        
        if let vc = viewController {
            return vc
        } else {
            return UIViewController()
        }
    }
}

