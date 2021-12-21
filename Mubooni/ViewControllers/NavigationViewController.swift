import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialViewController()
    }
    
    func setInitialViewController() {
        if Helper.getBoolPREF(UserDefaultConstants.PREF_IS_FIRST_LAUNCH) {
            if let vc = ViewControllerHelper.getViewController(ofType: .MainViewController) as? MainViewController {
                viewControllers = [vc]
            }
        }
        else {
            Helper.setBoolPREF(true, key: UserDefaultConstants.PREF_IS_FIRST_LAUNCH)
            if let vc = ViewControllerHelper.getViewController(ofType: .IntroScreensViewController) as? IntroScreensViewController {
                viewControllers = [vc]
            }
        }
    }
}
