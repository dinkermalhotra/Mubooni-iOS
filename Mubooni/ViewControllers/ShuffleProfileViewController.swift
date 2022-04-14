import UIKit

class ShuffleProfileViewController: UIViewController {

    @IBOutlet weak var lblAgent: UILabel!
    @IBOutlet weak var lblTenant: UILabel!
    @IBOutlet weak var lblServiceProvider: UILabel!
    @IBOutlet weak var lblLandlord: UILabel!
    
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

        configureRoles()
    }

    func configureRoles() {
        let roleId = settings?.userProfile?.roleId ?? ""
        self.setData(roleId)
        
        let subRole = settings?.userProfile?.subRole ?? ""
        let data = subRole.data(using: .utf8) ?? Data()
        do {
            if let subRoles = try JSONSerialization.jsonObject(with: data, options : []) as? [AnyObject] {
                for subRole in subRoles {
                    self.setData(subRole as? String ?? "")
                }
            }
            else {
                print("bad json")
            }
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func setData(_ id: String) {
        if id == Strings.ROLE_ID_AGENT {
            self.lblAgent.text = Strings.AGENT
            self.lblAgent.textColor = UIColor.black.withAlphaComponent(0.8)
        }
        
        if id == Strings.ROLE_ID_TENANT {
            self.lblTenant.text = Strings.TENANT
            self.lblTenant.textColor = UIColor.black.withAlphaComponent(0.8)
        }
        
        if id == Strings.ROLE_ID_LANDLORD {
            self.lblLandlord.text = Strings.LANDLORD
            self.lblLandlord.textColor = UIColor.black.withAlphaComponent(0.8)
        }
        
        if id == Strings.ROLE_ID_SERVICE_PROVIDER {
            self.lblServiceProvider.text = Strings.SERVICE_PROVIDER
            self.lblServiceProvider.textColor = UIColor.black.withAlphaComponent(0.8)
        }
    }
}

// MARK: - UIBUTTON ACTIONS
extension ShuffleProfileViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func agentClicked(_ sender: UIButton) {
        if lblAgent.text?.contains("JOIN") ?? false {
            print("Join")
        }
        else {
            var popToController: UIViewController?
            
            for controller in (self.navigationController?.viewControllers ?? [UIViewController]()) {
                if controller.isKind(of: AgentDashboardViewController.self) {
                    popToController = controller
                    
                    break
                }
            }
            
            if popToController != nil {
                self.navigationController?.popToViewController(popToController ?? UIViewController(), animated: true)
            }
            else {
                if let vc = ViewControllerHelper.getViewController(ofType: .AgentDashboardViewController) as? AgentDashboardViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @IBAction func tenantClicked(_ sender: UIButton) {
        if lblTenant.text?.contains("JOIN") ?? false {
            print("Join")
        }
        else {
            var popToController: UIViewController?
            
            for controller in (self.navigationController?.viewControllers ?? [UIViewController]()) {
                if controller.isKind(of: TenantDashboardViewController.self) {
                    popToController = controller
                    
                    break
                }
            }
            
            if popToController != nil {
                self.navigationController?.popToViewController(popToController ?? UIViewController(), animated: true)
            }
            else {
                if let vc = ViewControllerHelper.getViewController(ofType: .TenantDashboardViewController) as? TenantDashboardViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @IBAction func serviceProviderClicked(_ sender: UIButton) {
        if lblServiceProvider.text?.contains("JOIN") ?? false {
            print("Join")
        }
        else {
            var popToController: UIViewController?
            
            for controller in (self.navigationController?.viewControllers ?? [UIViewController]()) {
                if controller.isKind(of: ServiceProviderDashboardViewController.self) {
                    popToController = controller
                    
                    break
                }
            }
            
            if popToController != nil {
                self.navigationController?.popToViewController(popToController ?? UIViewController(), animated: true)
            }
            else {
                if let vc = ViewControllerHelper.getViewController(ofType: .ServiceProviderDashboardViewController) as? ServiceProviderDashboardViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @IBAction func landlordClicked(_ sender: UIButton) {
        if lblLandlord.text?.contains("JOIN") ?? false {
            print("Join")
        }
        else {
            var popToController: UIViewController?
            
            for controller in (self.navigationController?.viewControllers ?? [UIViewController]()) {
                if controller.isKind(of: AgentDashboardViewController.self) {
                    popToController = controller
                    
                    break
                }
            }
            
            if popToController != nil {
                self.navigationController?.popToViewController(popToController ?? UIViewController(), animated: true)
            }
            else {
                if let vc = ViewControllerHelper.getViewController(ofType: .AgentDashboardViewController) as? AgentDashboardViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
