import UIKit
import DropDown

class AddPropertyUnitCell: UITableViewCell {

    @IBOutlet weak var txtPropertyFor: UITextField!
    @IBOutlet weak var txtUnitNumber: UITextField!
    @IBOutlet weak var txtPropertyType: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var txtLength: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtNumberOfDays: UITextField!
    @IBOutlet weak var txtPerDayRent: UITextField!
    @IBOutlet weak var shortStaysViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkShortStaysHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewPropertyFor: UIView!
    @IBOutlet weak var viewPropertyType: UIView!
    @IBOutlet weak var viewLength: UIView!
    @IBOutlet weak var viewShortStays: UIView!
    @IBOutlet weak var viewCheckShortStays: UIView!
    @IBOutlet weak var btnShortStay: UIButton!
    
    var propertyForDropDown = DropDown()
    var propertyTypeDropDown = DropDown()
    var lengthDropDown = DropDown()
    
    var unitTypeBedroom = [UnitType]()
    var unitTypeLand = [UnitType]()
    var area = [AreaType]()
    var areaLand = [AreaType]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewShortStays.isHidden = true
        viewCheckShortStays.isHidden = true
        shortStaysViewHeightConstraint.constant = 0
        checkShortStaysHeightConstraint.constant = 0
        
        txtPropertyFor.delegate = self
        txtUnitNumber.delegate = self
        txtPropertyType.delegate = self
        txtArea.delegate = self
        txtLength.delegate = self
        txtPrice.delegate = self
        txtNumberOfDays.delegate = self
        txtPerDayRent.delegate = self
        
        setupPropertyForDropDown()
        fetchUnitType()
        fetchAreaType()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupPropertyForDropDown() {
        propertyForDropDown.anchorView = viewPropertyFor
        propertyForDropDown.bottomOffset = CGPoint(x: 0, y: 50)
        if AddProperty.estateName?.lowercased() == Strings.LAND.lowercased() {
            propertyForDropDown.dataSource = [Strings.FOR_RENT, Strings.FOR_SALE]
        }
        else {
            propertyForDropDown.dataSource = [Strings.FOR_RENT, Strings.FOR_SALE, Strings.FOR_SHORT_STAYS]
        }
        propertyForDropDown.backgroundColor = UIColor.white
        propertyForDropDown.textColor = UIColor.black
        propertyForDropDown.selectedTextColor = UIColor.black
        propertyForDropDown.separatorColor = UIColor.clear
        propertyForDropDown.textFont = MubooniFonts.FONT_ROBOTO_REGULAR_14 ?? UIFont.systemFont(ofSize: 14)
        propertyForDropDown.selectionAction = { [weak self] (index, item) in
            self?.txtPropertyFor.text = item
            
            if item.lowercased() == Strings.FOR_RENT.lowercased() && AddProperty.estateName?.lowercased() != Strings.LAND.lowercased() {
                self?.viewCheckShortStays.isHidden = false
                self?.checkShortStaysHeightConstraint.constant = 32
            }
            else {
                self?.viewCheckShortStays.isHidden = true
                self?.checkShortStaysHeightConstraint.constant = 0
            }
            
            if item.lowercased() == Strings.FOR_RENT.lowercased() {
                self?.txtPrice.placeholder = Strings.MONTHLY_RENT
            }
            else if item.lowercased() == Strings.FOR_SALE.lowercased() {
                self?.txtPrice.placeholder = Strings.SELLING_PRICE
            }
            else if item.lowercased() == Strings.FOR_SHORT_STAYS.lowercased() {
                
            }
            
            addPropertyDetailsViewControllerDelegate?.refreshTableView()
        }
    }
    
    func setupPropertyTypeDropDown() {
        var propertyType = [String]()
        
        if AddProperty.estateName?.lowercased() == Strings.LAND.lowercased() {
            for unitType in unitTypeLand {
                propertyType.append(unitType.unitName)
            }
        }
        else {
            for unitType in unitTypeBedroom {
                propertyType.append(unitType.unitName)
            }
        }
        
        txtPropertyType.placeholder = propertyType[0]
        propertyTypeDropDown.anchorView = viewPropertyType
        propertyTypeDropDown.bottomOffset = CGPoint(x: 0, y: 50)
        propertyTypeDropDown.dataSource = propertyType
        propertyTypeDropDown.backgroundColor = UIColor.white
        propertyTypeDropDown.textColor = UIColor.black
        propertyTypeDropDown.selectedTextColor = UIColor.black
        propertyTypeDropDown.separatorColor = UIColor.clear
        propertyTypeDropDown.textFont = MubooniFonts.FONT_ROBOTO_REGULAR_14 ?? UIFont.systemFont(ofSize: 14)
        propertyTypeDropDown.selectionAction = { [weak self] (index, item) in
            self?.txtPropertyType.text = item
        }
    }
    
    func setupLengthDropDown() {
        var areaType = [String]()
        
        if AddProperty.estateName?.lowercased() == Strings.LAND.lowercased() {
            for value in areaLand {
                areaType.append(value.areaSizeName)
            }
        }
        else {
            for value in area {
                areaType.append(value.areaSizeName)
            }
        }
        
        txtLength.placeholder = areaType[0]
        lengthDropDown.anchorView = viewLength
        lengthDropDown.bottomOffset = CGPoint(x: 0, y: 50)
        lengthDropDown.dataSource = areaType
        lengthDropDown.backgroundColor = UIColor.white
        lengthDropDown.textColor = UIColor.black
        lengthDropDown.selectedTextColor = UIColor.black
        lengthDropDown.separatorColor = UIColor.clear
        lengthDropDown.textFont = MubooniFonts.FONT_ROBOTO_REGULAR_14 ?? UIFont.systemFont(ofSize: 14)
        lengthDropDown.selectionAction = { [weak self] (index, item) in
            self?.txtLength.text = item
        }
    }
}

// MARK: - UITEXTFLIED DELEGATE
extension AddPropertyUnitCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtPropertyFor {
            if propertyForDropDown.isHidden == true {
                propertyForDropDown.show()
            }
            else {
                propertyForDropDown.hide()
            }
            
            return false
        }
        else if textField == txtPropertyType {
            if propertyTypeDropDown.isHidden == true {
                propertyTypeDropDown.show()
            }
            else {
                propertyTypeDropDown.hide()
            }
            
            return false
        }
        else if textField == txtLength {
            if lengthDropDown.isHidden == true {
                lengthDropDown.show()
            }
            else {
                lengthDropDown.hide()
            }
            
            return false
        }
        else {
            return true
        }
    }
}

// MARK: - API CALL
extension AddPropertyUnitCell {
    func fetchUnitType() {
        WSManager.wsCallGetUnitType { isSuccess, message, unitType in
            if isSuccess {
                self.unitTypeBedroom = unitType?.filter({ value in
                    value.estateType.lowercased() != Strings.LAND.lowercased()
                }) ?? []
                
                self.unitTypeLand = unitType?.filter({ value in
                    value.estateType.lowercased() == Strings.LAND.lowercased()
                }) ?? []
                
                self.setupPropertyTypeDropDown()
            }
        }
    }
    
    func fetchAreaType() {
        WSManager.wsCallGetAreaType { isSuccess, message, areaType in
            if isSuccess {
                self.area = areaType?.filter({ value in
                    value.estateSizeType.lowercased() != Strings.LAND.lowercased()
                }) ?? []
                
                self.areaLand = areaType?.filter({ value in
                    value.estateSizeType.lowercased() == Strings.LAND.lowercased()
                }) ?? []
                
                self.setupLengthDropDown()
            }
        }
    }
}
