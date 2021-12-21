import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var userProfile: UserProfile?
    
    var titles = ["Profile", "Notifications", "Logout"]
    var images = [UIImage(named: "ic_profile_gray"), UIImage(named: "ic_notification_gray"), UIImage(named: "ic_logout_gray")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                vc.userProfile = userProfile
                self.navigationController?.pushViewController(vc, animated: true)
            }
        default:
            break
        }
    }
}
