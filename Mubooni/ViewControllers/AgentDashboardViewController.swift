import UIKit

class AgentDashboardViewController: UIViewController {

    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    var userProfile: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }

    func setData() {
        lblName.text = userProfile?.name ?? ""
    }
}

// MARK: - UIBUTTON ACTIONS
extension AgentDashboardViewController {
    @IBAction func profileClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .ProfileViewController) as? ProfileViewController {
            vc.userProfile = userProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func notificationClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func findServiceProviderClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .FindServiceProviderViewController) as? FindServiceProviderViewController {
            vc.userProfile = userProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func addPropertyClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .AddPropertyDescriptionViewController) as? AddPropertyDescriptionViewController {
            vc.userProfile = userProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func myPropertiesClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .MyPropertiesViewController) as? MyPropertiesViewController {
            vc.userProfile = userProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func reportsClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func invoicesClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func chatClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func shuffleProfileClicked(_ sender: UIButton) {
        
    }
}
