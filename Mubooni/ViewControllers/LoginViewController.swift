import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
// MARK: - UIBUTTON ACTIONS
extension LoginViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func googleClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func appleClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func facebookClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func loginByEmailClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .SignInViewController) as? SignInViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
