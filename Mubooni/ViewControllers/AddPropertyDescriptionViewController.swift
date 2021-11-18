import UIKit
import DropDown

class AddPropertyDescriptionViewController: UIViewController {

    @IBOutlet weak var txtPropertyType: UITextField!
    @IBOutlet weak var txtBuildingName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCurrentLocation: UITextField!
    @IBOutlet weak var viewProperty: UIView!
    
    var propertyDropDown = DropDown()
    var propertyTypes = [PropertyTypes]()
    var typeId = ""
    var userProfile: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPropertyTypes()
    }
    
    func setupPropertyDropDown() {
        var types = [String]()
        for i in 0..<self.propertyTypes.count {
            let dict = self.propertyTypes[i]
            
            types.append(dict.typeName)
        }
        
        self.propertyDropDown.anchorView = self.viewProperty
        self.propertyDropDown.bottomOffset = CGPoint(x: 0, y: 50)
        self.propertyDropDown.dataSource = types
        self.propertyDropDown.backgroundColor = UIColor.white
        self.propertyDropDown.textColor = UIColor.black
        self.propertyDropDown.selectedTextColor = UIColor.black
        self.propertyDropDown.separatorColor = UIColor.clear
        self.propertyDropDown.textFont = MubooniFonts.FONT_ROBOTO_REGULAR_14 ?? UIFont.systemFont(ofSize: 14)
        self.propertyDropDown.selectionAction = { [weak self] (index, item) in
            self?.txtPropertyType.text = item
            self?.typeId = self?.propertyTypes[index].id ?? ""
        }
    }
}

// MARK: - UIBUTTON ACTIONS
extension AddPropertyDescriptionViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        
    }
}

// MARK: - UITEXTFIELD DELEGATE
extension AddPropertyDescriptionViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtPropertyType {
            if propertyDropDown.isHidden == true {
                propertyDropDown.show()
            }
            else {
                propertyDropDown.hide()
            }
            
            return false
        }
        else {
            return true
        }
    }
}

// MARK: - API CALL
extension AddPropertyDescriptionViewController {
    func fetchPropertyTypes() {
        WSManager.wsCallGetPropertyTypes { isSuccess, message, response in
            if isSuccess {
                self.propertyTypes = response ?? []
                self.setupPropertyDropDown()
            }
            else {
                Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: message)
            }
        }
    }
}
