import UIKit
import SDWebImage

class MainViewController: UIViewController {

    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var featuredPropertiesCollectionView: UICollectionView!
    @IBOutlet weak var propertiesCollectionView: UICollectionView!
    
    var featuredProperties = [Properties]()
    var properties = [Properties]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: AppConstants.PORTRAIT_SCREEN_WIDTH, height: featuredPropertiesCollectionView.frame.size.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        featuredPropertiesCollectionView.collectionViewLayout = layout
        propertiesCollectionView.collectionViewLayout = layout
        
        Helper.showLoader(onVC: self)
        fetchFeaturedProperties()
        fetchProperties()
    }

}

// MARK: - UIBUTTON ACTIONS
extension MainViewController {
    @IBAction func userClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .LoginViewController) as? LoginViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UICOLLECTIONVIEW METHODS
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featuredPropertiesCollectionView {
            return featuredProperties.count
        }
        else {
            return properties.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.MainFeaturedCell, for: indexPath) as! MainFeaturedCell
        
        if collectionView == featuredPropertiesCollectionView {
            let dict = featuredProperties[indexPath.row]
            
            cell.lblLocation.text = dict.address
            
            let unit = dict.units.count > 0 ? dict.units[0] : nil
            cell.lblPrice.text = unit?.unitStatus.lowercased() == Strings.UNIT_STATUS_SALE.lowercased() ? "\(Strings.SELLING_PRICE): \(Strings.KES)\(unit?.monthlyRent ?? "")" : "\(Strings.MONTHLY_RENT): \(Strings.KES)\(unit?.monthlyRent ?? "")"
        }
        else {
            let dict = properties[indexPath.row]
            
            cell.lblLocation.text = dict.address
            
            let unit = dict.units.count > 0 ? dict.units[0] : nil
            cell.lblPrice.text = unit?.unitStatus.lowercased() == Strings.UNIT_STATUS_SALE.lowercased() ? "\(Strings.SELLING_PRICE): \(Strings.KES)\(unit?.monthlyRent ?? "")" : "\(Strings.MONTHLY_RENT): \(Strings.KES)\(unit?.monthlyRent ?? "")"
        }
        
        return cell
    }
}

// MARK: - API CALL
extension MainViewController {
    func fetchFeaturedProperties() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_FEATURED_STATUS: "1" as AnyObject]
        WSManager.wsCallFeaturedProperties(params) { isSuccess, message, response in
            Helper.hideLoader(onVC: self)
            
            self.featuredProperties = response ?? []
            self.featuredPropertiesCollectionView.reloadData()
        }
    }
    
    func fetchProperties() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_FEATURED_STATUS: "0" as AnyObject]
        WSManager.wsCallFeaturedProperties(params) { isSuccess, message, response in
            Helper.hideLoader(onVC: self)
            
            self.properties = response ?? []
            self.propertiesCollectionView.reloadData()
        }
    }
}
