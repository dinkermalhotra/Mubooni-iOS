import UIKit
import SDWebImage

class MyPropertiesViewController: UIViewController {

    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var properties = [Properties]()
    var userProfile: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: AppConstants.PORTRAIT_SCREEN_WIDTH, height: 300)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        
        Helper.showLoader(onVC: self)
        fetchMyProperties()
    }

}

// MARK: - UIBUTTON ACTIONS
extension MyPropertiesViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICOLLECTIONVIEW METHODS
extension MyPropertiesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.properties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.MyPropertiesCell, for: indexPath) as! MyPropertiesCell
        let dict = properties[indexPath.row]
        
        let block: SDExternalCompletionBlock? = {(image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) -> Void in
            //print(image)
            if (image == nil) {
                return
            }
        }
        
        if let url = URL(string: dict.app_Attachments.count > 0 ? "\(WebService.baseImageUrl)\(dict.app_Attachments[0].img)" : "") {
            cell.imgProperty.sd_setImage(with: url, completed: block)
        }
        
        cell.lblPropertyName.text = dict.address
        
        let unit = dict.units.count > 0 ? dict.units[0] : nil
        cell.lblPrice.text = unit?.unitStatus.lowercased() == Strings.UNIT_STATUS_SALE.lowercased() ? "\(Strings.SELLING_PRICE): \(Strings.KES)\(unit?.monthlyRent ?? "")" : "\(Strings.MONTHLY_RENT): \(Strings.KES)\(unit?.monthlyRent ?? "")"
        
        if dict.typeName.lowercased() == Strings.LAND.lowercased() {
            cell.imgFirst.image = #imageLiteral(resourceName: "ic_unit_type")
            cell.imgSecond.image = nil
            cell.imgThird.image = nil
            
            cell.lblFirst.text = dict.typeName
            cell.lblSecond.text = ""
            cell.lblThird.text = ""
        }
        else {
            cell.imgFirst.image = #imageLiteral(resourceName: "ic_bedroom")
            cell.imgSecond.image = #imageLiteral(resourceName: "ic_bath")
            cell.imgThird.image = #imageLiteral(resourceName: "ic_unit_type")
            
            cell.lblFirst.text = dict.units.count > 0 ? "\(dict.units[0].unitType == "1" ? "\(dict.units[0].unitType) \(Strings.BEDROOM)" : "\(dict.units[0].unitType) \(Strings.BEDROOMS)")" : ""
            cell.lblSecond.text = dict.units.count > 0 ? "\(dict.units[0].unitType == "1" ? "\(dict.units[0].unitType) \(Strings.BATH)" : "\(dict.units[0].unitType) \(Strings.BATHS)")" : ""
            cell.lblThird.text = dict.typeName
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = ViewControllerHelper.getViewController(ofType: .AgentPropertyDetailViewController) as? AgentPropertyDetailViewController {
            vc.property = properties[indexPath.row]
            vc.userProfile = userProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - API CALL
extension MyPropertiesViewController {
    func fetchMyProperties() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_LOG_USERID: userProfile?.userId as AnyObject]
        WSManager.wsCallUserProperties(params) { isSuccess, message, response in
            Helper.hideLoader(onVC: self)
            
            self.properties = response ?? []
            self.collectionView.reloadData()
        }
    }
}
