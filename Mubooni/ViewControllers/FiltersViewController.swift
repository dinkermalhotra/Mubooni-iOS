import UIKit

class FiltersViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var areaSlider: UISlider!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var lblKmUpto: UILabel!
    @IBOutlet weak var lblAreaUpto: UILabel!
    @IBOutlet weak var lblPriceUpto: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var propertyTypeCollectionView: UICollectionView!
    @IBOutlet weak var propertyForCollectionView: UICollectionView!
    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var typeViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var unitTypeCollectionViewHeightConstraint: NSLayoutConstraint!
    
    var propertyTypes = [PropertyTypes]()
    var propertyFor = [Strings.RENT, Strings.BUY, Strings.LEASE, Strings.SHORT_STAY]
    var unitTypeBedroom = [UnitType]()
    var unitTypeLand = [UnitType]()
    
    var area = ""
    var distance = ""
    var latitude = ""
    var longitude = ""
    var price = ""
    
    var selectedPropertyTypeId = ""
    var selectedPropertyType = ""
    var selectedPropertyFor = ""
    var selectedUnitType = ""
    var selectedUnitTypeId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViewLayout()
        setupCurrentLocation()
        setupSliders()
        
        fetchPropertyType()
        fetchUnitType()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backView.roundCorners(corners: [.topLeft, .topRight], radius: 5)
    }
    
    func setupCollectionViewLayout() {
        if let collectionViewLayout = typeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    func setupCurrentLocation() {
        LocationManager.shared.requestLocation()
        LocationManager.shared.onCompletion = { (latitude, longitude, address) in
            self.latitude = latitude
            self.longitude = longitude
        }
    }
    
    func setupSliders() {
        distanceSlider.setThumbImage(UIImage(named: "ic_slider_head"), for: .normal)
        distanceSlider.setThumbImage(UIImage(named: "ic_slider_head"), for: .highlighted)
        
        areaSlider.setThumbImage(UIImage(named: "ic_slider_head"), for: .normal)
        areaSlider.setThumbImage(UIImage(named: "ic_slider_head"), for: .highlighted)
        
        priceSlider.setThumbImage(UIImage(named: "ic_slider_head"), for: .normal)
        priceSlider.setThumbImage(UIImage(named: "ic_slider_head"), for: .highlighted)
    }
}

// MARK: - UIBUTTONS ACTION
extension FiltersViewController {
    @IBAction func cancelClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetClicked(_ sender: UIButton) {
        distanceSlider.value = 0
        areaSlider.value = 0
        priceSlider.value = 0
        
        lblKmUpto.text = "(km) upto: 0)"
        lblAreaUpto.text = "(Sq. ft.) upto: 0)"
        lblPriceUpto.text = "(KES) upto: 0)"
        
        area = ""
        distance = ""
        price = ""
        
        selectedPropertyType = ""
        selectedPropertyTypeId = ""
        selectedPropertyFor = ""
        selectedUnitType = ""
        selectedUnitTypeId = ""
        
        propertyTypeCollectionView.reloadData()
        propertyForCollectionView.reloadData()
        typeCollectionView.reloadData()
    }
    
    @IBAction func distanceSliderValueChange(_ sender: UISlider) {
        lblKmUpto.text = "(km) upto: \(Int(sender.value))"
        distance = "\(Int(sender.value))"
    }
    
    @IBAction func areaSliderValueChange(_ sender: UISlider) {
        lblAreaUpto.text = "(Sq. ft.) upto: \(Int(sender.value))"
        area = "\(Int(sender.value))"
    }
    
    @IBAction func priceSliderValueChange(_ sender: UISlider) {
        lblPriceUpto.text = "(KES) upto: \(Int(sender.value))"
        price = "\(Int(sender.value))"
    }
    
    @IBAction func applyClicked(_ sender: UIButton) {
        txtLocation.resignFirstResponder()
        
        Helper.showLoader(onVC: self)
        getFilteredProperties()
    }
}

// MARK: - UITEXTFIELD DELEGATE
extension FiltersViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

// MARK: - UICOLLECTIONVIEW METHODS
extension FiltersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == propertyTypeCollectionView {
            return propertyTypes.count
        }
        else if collectionView == propertyForCollectionView {
            return propertyFor.count
        }
        else {
            if selectedPropertyType.lowercased() == Strings.LAND.lowercased() {
                return unitTypeLand.count
            }
            else {
                return unitTypeBedroom.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.CheckboxCell, for: indexPath) as! CheckboxCell
        
        if collectionView == propertyTypeCollectionView {
            let dict = propertyTypes[indexPath.row]
            cell.lblType.text = dict.typeName
            
            
            if selectedPropertyType == dict.typeName {
                cell.btnCheckbox.isSelected = true
            }
            else {
                cell.btnCheckbox.isSelected = false
            }
        }
        else if collectionView == propertyForCollectionView {
            cell.lblType.text = propertyFor[indexPath.row]
            
            if selectedPropertyFor == propertyFor[indexPath.row] {
                cell.btnCheckbox.isSelected = true
            }
            else {
                cell.btnCheckbox.isSelected = false
            }
        }
        else {
            var dict: UnitType?
            
            if selectedPropertyType.lowercased() == Strings.LAND.lowercased() {
                dict = unitTypeLand[indexPath.row]
            }
            else {
                dict = unitTypeBedroom[indexPath.row]
            }
            
            cell.lblType.text = dict?.unitName ?? ""
            
            if selectedUnitType == dict?.unitName ?? "" {
                cell.btnCheckbox.isSelected = true
            }
            else {
                cell.btnCheckbox.isSelected = false
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == propertyTypeCollectionView {
            let dict = propertyTypes[indexPath.row]
            
            selectedPropertyType = dict.typeName
            selectedPropertyTypeId = dict.id
            propertyTypeCollectionView.reloadData()
            typeCollectionView.reloadData()
            typeCollectionView.layoutIfNeeded()
            
            lblType.text = selectedPropertyType.lowercased() == Strings.LAND.lowercased() ? Strings.LAND.capitalized : Strings.BEDROOM.capitalized
            
            let height = typeCollectionView.collectionViewLayout.collectionViewContentSize.height
            unitTypeCollectionViewHeightConstraint.constant = height
            self.view.setNeedsLayout()
        }
        else if collectionView == propertyForCollectionView {
            selectedPropertyFor = propertyFor[indexPath.row]
            propertyForCollectionView.reloadData()
        }
        else {
            var dict: UnitType?
            
            if selectedPropertyType.lowercased() == Strings.LAND.lowercased() {
                dict = unitTypeLand[indexPath.row]
            }
            else {
                dict = unitTypeBedroom[indexPath.row]
            }
            
            selectedUnitType = dict?.unitName ?? ""
            selectedUnitTypeId = dict?.id ?? ""
            typeCollectionView.reloadData()
        }
    }
}

// MARK: - API CALL
extension FiltersViewController {
    func fetchPropertyType() {
        WSManager.wsCallGetPropertyTypes { isSuccess, message, response in
            if isSuccess {
                self.propertyTypes = response ?? []
                self.propertyTypeCollectionView.reloadData()
            }
            else {
                Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: message)
            }
        }
    }
    
    func fetchUnitType() {
        WSManager.wsCallGetUnitType { isSuccess, message, unitType in
            if isSuccess {
                self.unitTypeBedroom = unitType?.filter({ value in
                    value.estateType.lowercased() != Strings.LAND.lowercased()
                }) ?? []
                
                self.unitTypeLand = unitType?.filter({ value in
                    value.estateType.lowercased() == Strings.LAND.lowercased()
                }) ?? []
                
                self.typeCollectionView.reloadData()
                self.typeCollectionView.layoutIfNeeded()

                let height = self.typeCollectionView.collectionViewLayout.collectionViewContentSize.height
                self.unitTypeCollectionViewHeightConstraint.constant = height
                self.view.setNeedsLayout()
            }
            else {
                Helper.showOKAlert(onVC: self, title: Alert.ERROR, message: message)
            }
        }
    }
    
    func getFilteredProperties() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_SEARCHED: txtLocation.text as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_ESTATE_TYPE: selectedPropertyTypeId as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_UNIT_TYPE: selectedUnitTypeId as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_UNITSTATUS: selectedPropertyFor as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_DISTANCE: distance as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_PRICE: price as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_AREA: area as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_LAT: latitude as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_LNG: longitude as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_REG_TYPE: Strings.ALL as AnyObject]
        WSManager.wsCallFilteredProperties(params) { isSuccess, message, properties in
            Helper.hideLoader(onVC: self)
            if let vc = ViewControllerHelper.getViewController(ofType: .FilteredPropertiesViewController) as? FilteredPropertiesViewController {
                vc.filteredProperties = properties ?? []
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
