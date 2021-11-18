import UIKit
import CountryPickerView
import SDWebImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgIdProof: UIImageView!
    @IBOutlet weak var imgOtherDocument: UIImageView!
    @IBOutlet weak var imgGoogleVerified: UIImageView!
    @IBOutlet weak var imgAppleVerified: UIImageView!
    @IBOutlet weak var imgFacebookVerified: UIImageView!
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
        
        imgProfile.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleTapOnProfileImage)))
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
    
    @objc func handleTapOnProfileImage() {
        Helper.showActionAlert(onVC: self, title: nil, titleOne: Strings.TAKE_PHOTO, actionOne: takeNewPhotoFromCamera, titleTwo: Strings.CHOOSE_PHOTO, actionTwo: choosePhotoFromExistingImages)
    }
}

// MARK: - UIBUTTON ACTIONS
extension ProfileViewController {
    @IBAction func profileClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editProfileClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            countryPicker.isUserInteractionEnabled = true
            imgProfile.isUserInteractionEnabled = true
            txtName.isUserInteractionEnabled = true
            txtPhone.isUserInteractionEnabled = true
            txtEmail.isUserInteractionEnabled = true
            txtAddress.isUserInteractionEnabled = true
            btnAddMoreDocument.isUserInteractionEnabled = true
            
            countryPicker.backgroundColor = UIColor.white
            txtName.backgroundColor = UIColor.white
            txtPhone.backgroundColor = UIColor.white
            txtEmail.backgroundColor = UIColor.white
            txtAddress.backgroundColor = UIColor.white
            
            if userProfile?.kenyaId == "" {
                txtKenyaId.backgroundColor = UIColor.white
                txtKenyaId.isUserInteractionEnabled = true
                viewUploadKenyaId.isUserInteractionEnabled = true
            }
        }
        else {
            countryPicker.isUserInteractionEnabled = false
            imgProfile.isUserInteractionEnabled = false
            txtName.isUserInteractionEnabled = false
            txtPhone.isUserInteractionEnabled = false
            txtEmail.isUserInteractionEnabled = false
            txtAddress.isUserInteractionEnabled = false
            txtKenyaId.isUserInteractionEnabled = false
            viewUploadKenyaId.isUserInteractionEnabled = false
            btnAddMoreDocument.isUserInteractionEnabled = false
            
            countryPicker.backgroundColor = UIColor.clear
            txtName.backgroundColor = UIColor.clear
            txtPhone.backgroundColor = UIColor.clear
            txtEmail.backgroundColor = UIColor.clear
            txtAddress.backgroundColor = UIColor.clear
            txtKenyaId.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func emailVerifyClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func phoneVerifyClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func addMoreDocumentClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func googleClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func appleClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func facebookClicked(_ sender: UIButton) {
        
    }
}

// MARK: - UIIMAGEPICKERCONTROLLER DELEGAT
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takeNewPhotoFromCamera() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.SourceType.camera
        self.present(picker, animated: true, completion: nil)
    }
    
    func choosePhotoFromExistingImages() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        DispatchQueue.main.async {
            self.imgProfile.image = editedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
        
        imgFacebookVerified.isHidden = userProfile?.facebookId == "" ? true : false
        imgGoogleVerified.isHidden = userProfile?.googleId == "" ? true : false
        
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
