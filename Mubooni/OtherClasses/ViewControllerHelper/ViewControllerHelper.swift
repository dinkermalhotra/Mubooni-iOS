struct ViewControllerIdentifiers {
    
    static let AddPropertyAmenitiesViewController   = "AddPropertyAmenitiesViewController"
    static let AddPropertyDescriptionViewController = "AddPropertyDescriptionViewController"
    static let AddPropertyDetailsViewController     = "AddPropertyDetailsViewController"
    static let AddPropertyMediaViewController       = "AddPropertyMediaViewController"
    static let AgentDashboardViewController         = "AgentDashboardViewController"
    static let AgentPropertyDetailViewController    = "AgentPropertyDetailViewController"
    static let BookShortStayViewController          = "BookShortStayViewController"
    static let FilteredPropertiesViewController     = "FilteredPropertiesViewController"
    static let FiltersViewController                = "FiltersViewController"
    static let FindServiceProviderViewController    = "FindServiceProviderViewController"
    static let InquirySubmissionViewController      = "InquirySubmissionViewController"
    static let IntroScreensViewController           = "IntroScreensViewController"
    static let JobListViewController                = "JobListViewController"
    static let LoginViewController                  = "LoginViewController"
    static let MainViewController                   = "MainViewController"
    static let MyPropertiesViewController           = "MyPropertiesViewController"
    static let ProfileViewController                = "ProfileViewController"
    static let SearchOnMapViewController            = "SearchOnMapViewController"
    static let ServiceProviderDetailViewController  = "ServiceProviderDetailViewController"
    static let ServiceProviderDashboardViewController = "ServiceProviderDashboardViewController"
    static let ServiceReportViewController          = "ServiceReportViewController"
    static let SettingsViewController               = "SettingsViewController"
    static let ShuffleProfileViewController         = "ShuffleProfileViewController"
    static let SignInViewController                 = "SignInViewController"
    static let SignupViewController                 = "SignupViewController"
    static let TenantDashboardViewController        = "TenantDashboardViewController"
    static let TenantListViewController             = "TenantListViewController"
}

import UIKit

enum ViewControllerType {
    case AddPropertyAmenitiesViewController
    case AddPropertyDescriptionViewController
    case AddPropertyDetailsViewController
    case AddPropertyMediaViewController
    case AgentDashboardViewController
    case AgentPropertyDetailViewController
    case BookShortStayViewController
    case FilteredPropertiesViewController
    case FiltersViewController
    case FindServiceProviderViewController
    case InquirySubmissionViewController
    case IntroScreensViewController
    case JobListViewController
    case LoginViewController
    case MainViewController
    case MyPropertiesViewController
    case ProfileViewController
    case SearchOnMapViewController
    case ServiceProviderDetailViewController
    case ServiceProviderDashboardViewController
    case ServiceReportViewController
    case SettingsViewController
    case ShuffleProfileViewController
    case SignInViewController
    case SignupViewController
    case TenantDashboardViewController
    case TenantListViewController
}

class ViewControllerHelper: NSObject {
    
    // This is used to retirve view controller and intents to reutilize the common code.
    
    class func getViewController(ofType viewControllerType: ViewControllerType) -> UIViewController {
        var viewController: UIViewController?
        let agentStoryboard = UIStoryboard(name: "Agent", bundle: nil)
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let serviceProvider = UIStoryboard(name: "ServiceProvider", bundle: nil)
        let tenant = UIStoryboard(name: "Tenant", bundle: nil)
        
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
        else if viewControllerType == .AgentPropertyDetailViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.AgentPropertyDetailViewController) as! AgentPropertyDetailViewController
        }
        else if viewControllerType == .FindServiceProviderViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.FindServiceProviderViewController) as! FindServiceProviderViewController
        }
        else if viewControllerType == .JobListViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.JobListViewController) as! JobListViewController
        }
        else if viewControllerType == .MyPropertiesViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.MyPropertiesViewController) as! MyPropertiesViewController
        }
        else if viewControllerType == .ServiceProviderDetailViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.ServiceProviderDetailViewController) as! ServiceProviderDetailViewController
        }
        else if viewControllerType == .ServiceReportViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.ServiceReportViewController) as! ServiceReportViewController
        }
        else if viewControllerType == .TenantListViewController {
            viewController = agentStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.TenantListViewController) as! TenantListViewController
        }// Main Storyboard
        else if viewControllerType == .BookShortStayViewController {
            viewController = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.BookShortStayViewController) as! BookShortStayViewController
        }
        else if viewControllerType == .FilteredPropertiesViewController {
            viewController = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.FilteredPropertiesViewController) as! FilteredPropertiesViewController
        }
        else if viewControllerType == .FiltersViewController {
            viewController = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.FiltersViewController) as! FiltersViewController
        }
        else if viewControllerType == .InquirySubmissionViewController {
            viewController = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.InquirySubmissionViewController) as! InquirySubmissionViewController
        }
        else if viewControllerType == .ProfileViewController {
            viewController = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.ProfileViewController) as! ProfileViewController
        }
        else if viewControllerType == .SearchOnMapViewController {
            viewController = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.SearchOnMapViewController) as! SearchOnMapViewController
        }
        else if viewControllerType == .SettingsViewController {
            viewController = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.SettingsViewController) as! SettingsViewController
        }
        else if viewControllerType == .ShuffleProfileViewController {
            viewController = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.ShuffleProfileViewController) as! ShuffleProfileViewController
        } // Service Provider
        else if viewControllerType == .ServiceProviderDashboardViewController {
            viewController = serviceProvider.instantiateViewController(withIdentifier: ViewControllerIdentifiers.ServiceProviderDashboardViewController) as! ServiceProviderDashboardViewController
        } // Tenant
        else if viewControllerType == .TenantDashboardViewController {
            viewController = tenant.instantiateViewController(withIdentifier: ViewControllerIdentifiers.TenantDashboardViewController) as! TenantDashboardViewController
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

