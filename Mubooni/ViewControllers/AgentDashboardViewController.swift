import UIKit

class AgentDashboardViewController: UIViewController {

    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    var _settings: SettingsManager?
    
    var settings: SettingsManagerProtocol?
    {
        if let _ = WSManager._settings {
        }
        else {
            WSManager._settings = SettingsManager()
        }

        return WSManager._settings
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }

    func setData() {
        lblName.text = settings?.userProfile?.name ?? ""
    }
}

// MARK: - UIBUTTON ACTIONS
extension AgentDashboardViewController {
    @IBAction func settingsClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .SettingsViewController) as? SettingsViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func findServiceProviderClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .FindServiceProviderViewController) as? FindServiceProviderViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func addPropertyClicked(_ sender: UIButton) {
        Helper.showLoader(onVC: self)
        fetchMyProperties()
    }
    
    @IBAction func myPropertiesClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .MyPropertiesViewController) as? MyPropertiesViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func jobListClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .JobListViewController) as? JobListViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func invoicesClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .ServiceReportViewController) as? ServiceReportViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func tenantClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .TenantListViewController) as? TenantListViewController {
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
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_LOG_USERID: settings?.userProfile?.userId as AnyObject]
        WSManager.wsCallUserProperties(params) { isSuccess, message, response in
            self.propertyLimit(response?.count ?? 0)
        }
    }
    
    func propertyLimit(_ myPropertiesCount: Int) {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_LOG_USERID: settings?.userProfile?.userId as AnyObject]
        WSManager.wsCallGetPropertyLimit(params) { isSuccess, message, limit in
            Helper.hideLoader(onVC: self)
            
            if isSuccess {
                let newLimit = Int(limit) ?? 0
                
                if newLimit > myPropertiesCount {
                    if let vc = ViewControllerHelper.getViewController(ofType: .AddPropertyDescriptionViewController) as? AddPropertyDescriptionViewController {
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
