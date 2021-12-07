import UIKit
import SDWebImage

class MainViewController: UIViewController {

    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var featuredPropertiesCollectionView: UICollectionView!
    @IBOutlet weak var propertiesCollectionView: UICollectionView!
    @IBOutlet weak var serviceProviderCollectionView: UICollectionView!
    @IBOutlet weak var viewSearch: UIView!
    
    var featuredProperties = [Properties]()
    var properties = [Properties]()
    var serviceProviders = [ServiceProviders]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionViewLayout()
        
        viewSearch.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(searchClicked)))
        
        Helper.showLoader(onVC: self)
        fetchFeaturedProperties()
        fetchProperties()
        fetchServiceProviders()
    }

    func setupCollectionViewLayout() {
        let featuredPropertiesLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        featuredPropertiesLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        featuredPropertiesLayout.itemSize = CGSize(width: AppConstants.PORTRAIT_SCREEN_WIDTH, height: featuredPropertiesCollectionView.frame.size.height)
        featuredPropertiesLayout.minimumInteritemSpacing = 0
        featuredPropertiesLayout.minimumLineSpacing = 0
        featuredPropertiesLayout.scrollDirection = .horizontal
        featuredPropertiesCollectionView.collectionViewLayout = featuredPropertiesLayout
        
        let propertiesLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        propertiesLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        propertiesLayout.itemSize = CGSize(width: AppConstants.PORTRAIT_SCREEN_WIDTH, height: propertiesCollectionView.frame.size.height)
        propertiesLayout.minimumInteritemSpacing = 0
        propertiesLayout.minimumLineSpacing = 0
        propertiesLayout.scrollDirection = .horizontal
        propertiesCollectionView.collectionViewLayout = propertiesLayout
        
        let serviceProviderLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        serviceProviderLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        serviceProviderLayout.itemSize = CGSize(width: AppConstants.PORTRAIT_SCREEN_WIDTH, height: serviceProviderCollectionView.frame.size.height)
        serviceProviderLayout.minimumInteritemSpacing = 0
        serviceProviderLayout.minimumLineSpacing = 0
        serviceProviderLayout.scrollDirection = .horizontal
        serviceProviderCollectionView.collectionViewLayout = serviceProviderLayout
    }
    
    @objc func searchClicked() {
        if let vc = ViewControllerHelper.getViewController(ofType: .FiltersViewController) as? FiltersViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UIBUTTON ACTIONS
extension MainViewController {
    @IBAction func userClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .JobListViewController) as? JobListViewController {
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
        else if collectionView == propertiesCollectionView {
            return properties.count
        }
        else {
            return serviceProviders.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let block: SDExternalCompletionBlock? = {(image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) -> Void in
            //print(image)
            if (image == nil) {
                return
            }
        }

        if collectionView == featuredPropertiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.MainFeaturedCell, for: indexPath) as! MainFeaturedCell
            
            let dict = featuredProperties[indexPath.row]
            
            if let url = URL(string: dict.app_Attachments.count > 0 ? "\(WebService.baseImageUrl)\(dict.app_Attachments[0].img)" : "") {
                cell.imgProperty.sd_setImage(with: url, completed: block)
            }
            
            cell.lblLocation.text = dict.address
            
            let unit = dict.units.count > 0 ? dict.units[0] : nil
            cell.lblPrice.text = unit?.unitStatus.lowercased() == Strings.UNIT_STATUS_SALE.lowercased() ? "\(Strings.SELLING_PRICE): \(Strings.KES)\(unit?.monthlyRent ?? "")" : "\(Strings.MONTHLY_RENT): \(Strings.KES)\(unit?.monthlyRent ?? "")"
            
            return cell
        }
        else if collectionView == propertiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.MainFeaturedCell, for: indexPath) as! MainFeaturedCell
            
            let dict = properties[indexPath.row]
            
            if let url = URL(string: dict.app_Attachments.count > 0 ? "\(WebService.baseImageUrl)\(dict.app_Attachments[0].img)" : "") {
                cell.imgProperty.sd_setImage(with: url, completed: block)
            }
            
            cell.lblLocation.text = dict.address
            
            let unit = dict.units.count > 0 ? dict.units[0] : nil
            cell.lblPrice.text = unit?.unitStatus.lowercased() == Strings.UNIT_STATUS_SALE.lowercased() ? "\(Strings.SELLING_PRICE): \(Strings.KES)\(unit?.monthlyRent ?? "")" : "\(Strings.MONTHLY_RENT): \(Strings.KES)\(unit?.monthlyRent ?? "")"
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.ServiceProviderCell, for: indexPath) as! ServiceProviderCell
            
            let dict = serviceProviders[indexPath.row]
            
            if let url = URL(string: "\(WebService.baseImageUrl)\(dict.profile)") {
                cell.imgProfile.sd_setImage(with: url, completed: block)
            }

            cell.lblName.text = dict.name
            cell.lblSpecialisations.text = dict.specialisations
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == featuredPropertiesCollectionView {
            if let vc = ViewControllerHelper.getViewController(ofType: .AgentPropertyDetailViewController) as? AgentPropertyDetailViewController {
                vc.property = featuredProperties[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else if collectionView == propertiesCollectionView {
            if let vc = ViewControllerHelper.getViewController(ofType: .AgentPropertyDetailViewController) as? AgentPropertyDetailViewController {
                vc.property = properties[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else {
            if let vc = ViewControllerHelper.getViewController(ofType: .ServiceProviderDetailViewController) as? ServiceProviderDetailViewController {
                vc.serviceProvider = serviceProviders[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

// MARK: - API CALL
extension MainViewController {
    func fetchFeaturedProperties() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_FEATURED_STATUS: "1" as AnyObject]
        WSManager.wsCallFeaturedProperties(params) { isSuccess, message, response in
            
            self.featuredProperties = response ?? []
            self.featuredPropertiesCollectionView.reloadData()
        }
    }
    
    func fetchProperties() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_FEATURED_STATUS: "0" as AnyObject]
        WSManager.wsCallFeaturedProperties(params) { isSuccess, message, response in
            
            self.properties = response ?? []
            self.propertiesCollectionView.reloadData()
        }
    }
    
    func fetchServiceProviders() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_INDEX: Strings.DASHBOARD as AnyObject]
        WSManager.wsCallGetServiceProviders(params) { isSuccess, message, serviceProviders in
            Helper.hideLoader(onVC: self)
            
            self.serviceProviders = serviceProviders ?? []
            self.serviceProviderCollectionView.reloadData()
        }
    }
}
