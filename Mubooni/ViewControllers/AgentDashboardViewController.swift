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
        Helper.showLoader(onVC: self)
        fetchMyProperties()
    }
    
    @IBAction func myPropertiesClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .MyPropertiesViewController) as? MyPropertiesViewController {
            vc.userProfile = userProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func jobListClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .JobListViewController) as? JobListViewController {
            vc.userProfile = userProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func invoicesClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .ServiceReportViewController) as? ServiceReportViewController {
            vc.userProfile = userProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func tenantClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .TenantListViewController) as? TenantListViewController {
            vc.userProfile = userProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func shuffleProfileClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .ShuffleProfileViewController) as? ShuffleProfileViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - API CALL
extension AgentDashboardViewController {
    func fetchMyProperties() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_LOG_USERID: userProfile?.userId as AnyObject]
        WSManager.wsCallUserProperties(params) { isSuccess, message, response in
            self.propertyLimit(response?.count ?? 0)
        }
    }
    
    func propertyLimit(_ myPropertiesCount: Int) {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_LOG_USERID: userProfile?.userId as AnyObject]
        WSManager.wsCallGetPropertyLimit(params) { isSuccess, message, limit in
            Helper.hideLoader(onVC: self)
            
            if isSuccess {
                let newLimit = Int(limit) ?? 0
                
                if newLimit > myPropertiesCount {
                    if let vc = ViewControllerHelper.getViewController(ofType: .AddPropertyDescriptionViewController) as? AddPropertyDescriptionViewController {
                        vc.userProfile = self.userProfile
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                else {
                    Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: AlertMessages.PROPERTY_LIMIT_OVER)
                }
            }
            else {
                Helper.showOKAlert(onVC: self, title: Alert.ALERT, message: message)
            }
        }
    }
}
