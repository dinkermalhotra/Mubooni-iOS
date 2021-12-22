import UIKit
import AuthenticationServices
import FBSDKLoginKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

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

    func getFBUserData() {
        if((AccessToken.current) != nil) {
            GraphRequest(graphPath: "me", parameters: ["fields": "id, gender, email, name, picture.width(400).height(400)"]).start { connection, result, error in
                if (error == nil) {
                    print(result ?? [:])
                    
                    if let result = result as? [String: AnyObject] {
                        if let name = result["name"] as? String {
                            UserData.name = name
                        }
                        
                        if let fbId = result["id"] as? String {
                            UserData.facebookId = fbId
                        }
                        
                        if let email = result["email"] as? String {
                            UserData.email = email
                        }
                        
                        Helper.showLoader(onVC: self)
                        self.checkFacebookIdExist()
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
        
        Helper.showLoader(onVC: self)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
                Helper.hideLoader(onVC: self)
                print(error.localizedDescription)
                return
            }
            
            guard let authentication = user?.authentication, let idToken = authentication.idToken else {
                Helper.hideLoader(onVC: self)
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    Helper.hideLoader(onVC: self)
                    print(error.localizedDescription)
                    return
                }
                
                UserData.name = authResult?.user.displayName
                UserData.googleId = authResult?.user.uid
                UserData.email = authResult?.user.email
                
                self.checkGoogleIdExist()
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

// MARK: - API CALL
extension LoginViewController {
    func checkGoogleIdExist() {
        let params = [WSRequestParams.WS_REQS_PARAM_GOOGLE_EMAIL: UserData.email as AnyObject,
                      WSRequestParams.WS_REQS_PARAM_GOOGLE_ID: UserData.googleId as AnyObject]
        WSManager.wsCallCheckGoogleAccountExist(params) { isSuccess, userid in
            if isSuccess {
                Helper.hideLoader(onVC: self)
                if let vc = ViewControllerHelper.getViewController(ofType: .SignupViewController) as? SignupViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else {
                self.loginUser()
            }
        }
    }
    
    func checkFacebookIdExist() {
        let params = [WSRequestParams.WS_REQS_PARAM_FACEBOOK_EMAIL: UserData.email as AnyObject,
                      WSRequestParams.WS_REQS_PARAM_FACEBOOK_ID: UserData.facebookId as AnyObject]
        WSManager.wsCallCheckFacebookAccountExist(params) { isSuccess, userid in
            if isSuccess {
                Helper.hideLoader(onVC: self)
                if let vc = ViewControllerHelper.getViewController(ofType: .SignupViewController) as? SignupViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else {
                self.loginUser()
            }
        }
    }
    
    func loginUser() {
        var params: [String: AnyObject]?
        if UserData.facebookId != nil {
            params = [WSRequestParams.WS_REQS_PARAM_EMAIL: UserData.email as AnyObject,
                      WSRequestParams.WS_REQS_PARAM_FACEBOOK_ID: UserData.facebookId as AnyObject]
        }
        else {
            params = [WSRequestParams.WS_REQS_PARAM_EMAIL: UserData.email as AnyObject,
                      WSRequestParams.WS_REQS_PARAM_GOOGLE_ID: UserData.googleId as AnyObject]
        }
        
        WSManager.wsCallLogin(params ?? [:]) { isSuccess, message, userProfile in
            Helper.hideLoader(onVC: self)
            if isSuccess {
                self.settings?.userProfile = userProfile
                
                if let vc = ViewControllerHelper.getViewController(ofType: .AgentDashboardViewController) as? AgentDashboardViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else {
                Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: message)
            }
        }
    }
}
