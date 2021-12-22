import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var titles = ["Profile", "Notifications", "Logout"]
    var images = [UIImage(named: "ic_profile_gray"), UIImage(named: "ic_notification_gray"), UIImage(named: "ic_logout_gray")]
    
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

        // Do any additional setup after loading the view.
    }

    func performLogout() {
        settings?.userProfile = nil
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UIBUTTON ACTIONS
extension SettingsViewController {
    @IBAction func cressClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITABLEVIEW METHODS
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.SettingsCell, for: indexPath)
        
        cell.textLabel?.text = titles[indexPath.row]
        cell.imageView?.image = images[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if let vc = ViewControllerHelper.getViewController(ofType: .ProfileViewController) as? ProfileViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 1:
            break
        case 2:
            Helper.showOKCancelAlertWithCompletion(onVC: self, title: Alert.LOGOUT, message: AlertMessages.LOGOUT, btnOkTitle: Strings.YES, btnCancelTitle: Strings.NO, onOk: {
                self.performLogout()
            })
        default:
            break
        }
    }
}
