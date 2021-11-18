struct ViewControllerIdentifiers {
    
    static let AddPropertyAmenitiesViewController   = "AddPropertyAmenitiesViewController"
    static let AddPropertyDescriptionViewController = "AddPropertyDescriptionViewController"
    static let AddPropertyDetailsViewController     = "AddPropertyDetailsViewController"
    static let AddPropertyMediaViewController       = "AddPropertyMediaViewController"
    static let AgentDashboardViewController         = "AgentDashboardViewController"
    static let AgentPropertyDetailViewController    = "AgentPropertyDetailViewController"
    static let FindServiceProviderViewController    = "FindServiceProviderViewController"
    static let IntroScreensViewController           = "IntroScreensViewController"
    static let LoginViewController                  = "LoginViewController"
    static let MainViewController                   = "MainViewController"
    static let MyPropertiesViewController           = "MyPropertiesViewController"
    static let ProfileViewController                = "ProfileViewController"
    static let SignInViewController                 = "SignInViewController"
    static let SignupViewController                 = "SignupViewController"
}

import UIKit

enum ViewControllerType {
    case AddPropertyAmenitiesViewController
    case AddPropertyDescriptionViewController
    case AddPropertyDetailsViewController
    case AddPropertyMediaViewController
    case AgentDashboardViewController
    case AgentPropertyDetailViewController
    case FindServiceProviderViewController
    case IntroScreensViewController
    case LoginViewController
    case MainViewController
    case MyPropertiesViewController
    case ProfileViewController
    case SignInViewController
    case SignupViewController
}

class ViewControllerHelper: NSObject {
    
    // This is used to retirve view controller and intents to reutilize the common code.
    
    class func getViewController(ofType viewControllerType: ViewControllerType) -> UIViewController {
        var viewController: UIViewController?
        let agentStoryboard = UIStoryboard(name: "Agent", bundle: nil)
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
        } // Agent Storyboard
        else if viewControllerType == .AddPropertyAmenitiesViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.AddPropertyAmenitiesViewController) as! AddPropertyAmenitiesViewController
        }
        else if viewControllerType == .AddPropertyDescriptionViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.AddPropertyDescriptionViewController) as! AddPropertyDescriptionViewController
        }
        else if viewControllerType == .AddPropertyDetailsViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.AddPropertyDetailsViewController) as! AddPropertyDetailsViewController
        }
        else if viewControllerType == .AddPropertyMediaViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.AddPropertyMediaViewController) as! AddPropertyMediaViewController
        }
        else if viewControllerType == .AgentDashboardViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.AgentDashboardViewController) as! AgentDashboardViewController
        }
        else if viewControllerType == . AgentPropertyDetailViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.AgentPropertyDetailViewController) as! AgentPropertyDetailViewController
        }
        else if viewControllerType == .FindServiceProviderViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.FindServiceProviderViewController) as! FindServiceProviderViewController
        }
        else if viewControllerType == .MyPropertiesViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.MyPropertiesViewController) as! MyPropertiesViewController
        } // Main Storyboard
        else if viewControllerType == .ProfileViewController {
            viewController = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.ProfileViewController) as! ProfileViewController
        }
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

