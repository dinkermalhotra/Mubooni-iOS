import UIKit
import AuthenticationServices
import FBSDKLoginKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func getFBUserData() {
        if((AccessToken.current) != nil) {
            GraphRequest(graphPath: "me", parameters: ["fields": "id, gender, email, name, picture.width(400).height(400)"]).start { connection, result, error in
                if (error == nil) {
                    print(result ?? [:])
                    
                    if let result = result as? [String: AnyObject] {
                        if let name = result["name"] as? String {
                            let completeName = name.split(separator: " ")
                            //UserData.firstName = String(completeName[0])
                            //UserData.lastName = (completeName.count > 1 ? String(completeName[1]) : nil) ?? ""
                        }
                        
                        if let _fbId = result["id"] as? String {
                            //UserData.facebookId = _fbId
                        }
                        
                        if let _email = result["email"] as? String {
                            //UserData.email = _email
                        }
                        
                        if let _picture = result["picture"] as? [String: AnyObject] {
                            if let _data = _picture["data"] as? [String: AnyObject] {
                                if let _url = _data["url"] as? String {
                                    //UserData.imageUrl = URL.init(string: _url)
                                }
                            }
                        }
                        
                        //Helper.showLoader(onVC: self)
                        //self.socialLogin()
                    }
                }
            }
        }
    }
}
// MARK: - UIBUTTON ACTIONS
extension LoginViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func googleClicked(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let authentication = user?.authentication, let idToken = authentication.idToken else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    //Helper.hideLoader(onVC: self)
                    //Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: error.localizedDescription)
                    return
                }
                
                let userName = authResult?.user.displayName
//                UserData.gmailId = authResult?.user.uid
//                UserData.imageUrl = authResult?.user.photoURL
//                UserData.email = authResult?.user.email
//                UserData.phoneNumber = authResult?.user.phoneNumber
//
//                self.socialLogin()
            }
        }
    }
    
    @IBAction func appleClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func facebookClicked(_ sender: UIButton) {
        let fbLoginManager: LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email", "public_profile"], from: self, handler: {(result, error) -> Void in
            print(error?.localizedDescription ?? "No error")
            if (error == nil) {
                let fbloginresult: LoginManagerLoginResult = result!
                if (result?.isCancelled ?? true) {
                    return
                }
                
                if(fbloginresult.grantedPermissions.contains("email")) {
                    self.getFBUserData()
                    fbLoginManager.logOut()
                }
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func loginByEmailClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .SignInViewController) as? SignInViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
