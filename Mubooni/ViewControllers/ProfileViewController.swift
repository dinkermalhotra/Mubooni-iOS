import UIKit
import CountryPickerView
import SDWebImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgIdProof: UIImageView!
    @IBOutlet weak var imgOtherDocument: UIImageView!
    @IBOutlet weak var countryPicker: CountryPickerView!
    @IBOutlet weak var lblProfileTag: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtKenyaId: UITextField!
    @IBOutlet weak var btnAddMoreDocument: UIButton!
    @IBOutlet weak var btnEmailVerify: UIButton!
    @IBOutlet weak var btnPhoneVerify: UIButton!
    @IBOutlet weak var viewUploadKenyaId: UIView!
    
    var userProfile: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countryPicker.dataSource = self
        countryPicker.showCountryCodeInView = false
        countryPicker.countryDetailsLabel.font = MubooniFonts.FONT_ROBOTO_BOLD_16
        
        viewUploadKenyaId.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleTapOnUploadKenyaId)))
        
        Helper.showLoader(onVC: self)
        fetchUserProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        viewUploadKenyaId.addDashedBorder()
    }

    @objc func handleTapOnUploadKenyaId() {
        print("Tapped")
    }
}

// MARK: - UIBUTTON ACTIONS
extension ProfileViewController {
    @IBAction func profileClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editProfileClicked(_ sender: UIButton) {
        txtName.isUserInteractionEnabled = true
        txtPhone.isUserInteractionEnabled = true
        txtEmail.isUserInteractionEnabled = true
        txtAddress.isUserInteractionEnabled = true
        txtKenyaId.isUserInteractionEnabled = true
        viewUploadKenyaId.isUserInteractionEnabled = true
        btnAddMoreDocument.isUserInteractionEnabled = true
    }
    
    @IBAction func emailVerifyClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func phoneVerifyClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func addMoreDocumentClicked(_ sender: UIButton) {
        
    }
}

// MARK: - COUNTRYPICKER DATASOURCE
extension ProfileViewController: CountryPickerViewDataSource {
    func showPhoneCodeInList(in countryPickerView: CountryPickerView) -> Bool {
        return countryPickerView.tag == countryPicker.tag && true
    }
}

// MARK: - API CALL
extension ProfileViewController {
    func fetchUserProfile() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_LOG_USERID: userProfile?.userId as AnyObject]
        WSManager.wsCallGetUserProfile(params) { isSuccess, message, userProfile in
            Helper.hideLoader(onVC: self)
            
            if isSuccess {
                self.userProfile = userProfile
                self.setData(userProfile)
            }
            else {
                Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: message)
            }
        }
    }
    
    func setData(_ userProfile: UserProfile?) {
        let block: SDExternalCompletionBlock? = {(image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) -> Void in
            //print(image)
            if (image == nil) {
                return
            }
        }
        
        if userProfile?.isUserVerify == Strings.ONE {
            lblProfileTag.text = "  \(Strings.VERIFIED)  "
            lblProfileTag.backgroundColor = MubooniColors.greenColor
        }
        else {
            lblProfileTag.text = "  \(Strings.UNVERIFIED)  "
            lblProfileTag.backgroundColor = MubooniColors.redColor
        }
        
        lblAbout.text = userProfile?.about ?? ""
        
        countryPicker.countryDetailsLabel.text = "+\(userProfile?.countryCode ?? "")"
        txtName.text = userProfile?.name ?? ""
        txtPhone.text = userProfile?.mobile ?? ""
        txtEmail.text = userProfile?.email ?? ""
        txtAddress.text = userProfile?.address ?? ""
        txtKenyaId.text = userProfile?.kenyaId ?? ""
        
        btnEmailVerify.isSelected = userProfile?.isVerify == Strings.ONE ? true : false
        btnPhoneVerify.isSelected = userProfile?.isPhoneVerify == Strings.ONE ? true : false
        
        if !(userProfile?.idProof.isEmpty ?? true) {
            imgIdProof.isHidden = false
            viewUploadKenyaId.isHidden = true
            
            if let url = URL(string:  "\(WebService.baseImageUrl)\(userProfile?.idProof ?? "")") {
                self.imgIdProof.sd_setImage(with: url, completed: block)
            }
        }
        else {
            imgIdProof.isHidden = true
            viewUploadKenyaId.isHidden = false
        }
        
        if !(userProfile?.profile.isEmpty ?? true) {
            if let url = URL(string:  "\(WebService.baseImageUrl)\(userProfile?.profile ?? "")") {
                self.imgProfile.sd_setImage(with: url, completed: block)
            }
        }
        
        if !(userProfile?.attachedDoc.isEmpty ?? true) {
            btnAddMoreDocument.isHidden = true
            imgOtherDocument.isHidden = false
            
            if let url = URL(string:  "\(WebService.baseImageUrl)\(userProfile?.attachedDoc ?? "")") {
                self.imgOtherDocument.sd_setImage(with: url, completed: block)
            }
        }
        else {
            btnAddMoreDocument.isHidden = false
            imgOtherDocument.isHidden = true
        }
    }
}
