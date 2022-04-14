import UIKit

class TenantDashboardViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
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
extension TenantDashboardViewController {
    @IBAction func settingsClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .SettingsViewController) as? SettingsViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func shuffleProfileClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .ShuffleProfileViewController) as? ShuffleProfileViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
