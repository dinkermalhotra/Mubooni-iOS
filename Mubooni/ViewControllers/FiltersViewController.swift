import UIKit

class FiltersViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblCurrentLocation: UILabel!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var areaSlider: UISlider!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var lblKmUpto: UILabel!
    @IBOutlet weak var lblAreaUpto: UILabel!
    @IBOutlet weak var lblPriceUpto: UILabel!
    @IBOutlet weak var propertyTypeCollectionView: UICollectionView!
    @IBOutlet weak var propertyForCollectionView: UICollectionView!
    @IBOutlet weak var bedroomView: UIView!
    @IBOutlet weak var landView: UIView!
    @IBOutlet weak var landTypeCollectionView: UICollectionView!
    @IBOutlet weak var bedroomCollectionView: UICollectionView!
    @IBOutlet weak var btnApplyTopConstraint: NSLayoutConstraint!
    
    var bedroom = ["1", "2", "3", "3+"]
    var landType = [Strings.FREEHOLD, Strings.LEASEHOLD]
    var propertyTypes = [PropertyTypes]()
    var propertyFor = [Strings.RENT, Strings.BUY, Strings.LEASE, Strings.SHORT_STAY]
    var area = ""
    var distance = ""
    var latitude = ""
    var longitude = ""
    var price = ""
    var selectedBedroom = ""
    var selectedLandType = ""
    var selectedPropertyType = ""
    var selectedPropertyFor = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViewLayout()
        setupCurrentLocation()
        setupSliders()
        
        fetchPropertyType()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backView.roundCorners(corners: [.topLeft, .topRight], radius: 5)
    }
    
    func setupCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 30, height: 30)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal
        bedroomCollectionView.collectionViewLayout = layout
    }
    
    func setupCurrentLocation() {
        LocationManager.shared.requestLocation()
        LocationManager.shared.onCompletion = { (latitude, longitude, address) in
            self.lblCurrentLocation.text = address
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
        selectedBedroom = ""
        selectedLandType = ""
        selectedPropertyType = ""
        selectedPropertyFor = ""
        
        propertyTypeCollectionView.reloadData()
        propertyForCollectionView.reloadData()
        landTypeCollectionView.reloadData()
        bedroomCollectionView.reloadData()
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
        Helper.showLoader(onVC: self)
        getFilteredProperties()
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
        else if collectionView == bedroomCollectionView {
            return bedroom.count
        }
        else {
            return landType.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == propertyTypeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.CheckboxCell, for: indexPath) as! CheckboxCell
            
            let dict = propertyTypes[indexPath.row]
            cell.lblType.text = dict.typeName
            
            
            if selectedPropertyType == dict.typeName {
                cell.btnCheckbox.isSelected = true
            }
            else {
                cell.btnCheckbox.isSelected = false
            }
            
            if selectedPropertyType.lowercased() == Strings.LAND.lowercased() {
                bedroomView.isHidden = true
                landView.isHidden = false
            }
            else {
                bedroomView.isHidden = false
                landView.isHidden = true
            }
            
            return cell
        }
        else if collectionView == propertyForCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.CheckboxCell, for: indexPath) as! CheckboxCell
            
            cell.lblType.text = propertyFor[indexPath.row]
            
            if selectedPropertyFor == propertyFor[indexPath.row] {
                cell.btnCheckbox.isSelected = true
            }
            else {
                cell.btnCheckbox.isSelected = false
            }
            
            return cell
        }
        else if collectionView == bedroomCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.BedroomSelectionCell, for: indexPath) as! BedroomSelectionCell
            
            cell.lblType.text = bedroom[indexPath.row]
            
            if selectedBedroom == bedroom[indexPath.row] {
                cell.lblType.backgroundColor = MubooniColors.backgroundGreenColor
                cell.lblType.textColor = UIColor.white
            }
            else {
                cell.lblType.backgroundColor = UIColor.clear
                cell.lblType.textColor = UIColor.black.withAlphaComponent(0.8)
            }
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.CheckboxCell, for: indexPath) as! CheckboxCell
            
            cell.lblType.text = landType[indexPath.row]
            
            if selectedLandType == landType[indexPath.row] {
                cell.btnCheckbox.isSelected = true
            }
            else {
                cell.btnCheckbox.isSelected = false
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == propertyTypeCollectionView {
            let dict = propertyTypes[indexPath.row]
            
            selectedPropertyType = dict.typeName
            propertyTypeCollectionView.reloadData()
        }
        else if collectionView == propertyForCollectionView {
            selectedPropertyFor = propertyFor[indexPath.row]
            propertyForCollectionView.reloadData()
        }
        else if collectionView == bedroomCollectionView {
            selectedBedroom = bedroom[indexPath.row]
            bedroomCollectionView.reloadData()
        }
        else {
            selectedLandType = landType[indexPath.row]
            landTypeCollectionView.reloadData()
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
    
    func getFilteredProperties() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_SEARCHED: lblCurrentLocation.text as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_ESTATE_TYPE: "" as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_UNIT_TYPE: "" as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_UNIT_STATUS: "" as AnyObject,
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
