import UIKit
import SDWebImage

class FindServiceProviderViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnProfile: UIButton!
    
    var userProfile: UserProfile?
    var serviceProviders = [ServiceProviders]()
    var latitude = ""
    var longitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionViewLayout()
        fetchCurrentLocation()
    }

    func fetchCurrentLocation() {
        LocationManager.shared.requestLocation()
        LocationManager.shared.onCompletion = { (latitude, longitude, address) in
            self.latitude = latitude
            self.longitude = longitude
        }
    }
    
    func setupCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: AppConstants.PORTRAIT_SCREEN_WIDTH, height: 268)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - UIBUTTON ACTIONS
extension FindServiceProviderViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .ProfileViewController) as? ProfileViewController {
            vc.userProfile = userProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func notificationClicked(_ sender: UIButton) {
        
    }
}

// MARK: - UITEXTFIELD DELEGATE
extension FindServiceProviderViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        Helper.showLoader(onVC: self)
        searchServiceProvider()
        
        return true
    }
}

// MARK: - UICOLLECTIONVIEW METHODS
extension FindServiceProviderViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceProviders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.FindServiceProviderCell, for: indexPath) as! FindServiceProviderCell
        
        let block: SDExternalCompletionBlock? = {(image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) -> Void in
            //print(image)
            if (image == nil) {
                return
            }
        }
        
        let dict = serviceProviders[indexPath.row]
        
        if let url = URL(string: "\(WebService.baseImageUrl)\(dict.profile)") {
            cell.imgProfile.sd_setImage(with: url, completed: block)
        }

        cell.lblName.text = dict.name
        cell.lblSpecialisation.text = dict.specialisations
        cell.lblAddress.text = dict.address
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = ViewControllerHelper.getViewController(ofType: .ServiceProviderDetailViewController) as? ServiceProviderDetailViewController {
            vc.userProfile = userProfile
            vc.serviceProvider = serviceProviders[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - API CALL
extension FindServiceProviderViewController {
    func searchServiceProvider() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_LOG_USERID: userProfile?.userId as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_SEARCHED_SPECS: txtSearch.text as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_LOCATION_SPEC: "" as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_LAT: "30.752800" as AnyObject,
                                           WSRequestParams.WS_REQS_PARAM_LNG: "76.804504" as AnyObject]
        WSManager.wsCallSearchServiceProviders(params) { isSuccess, message, serviceProviders in
            Helper.hideLoader(onVC: self)
            
            self.serviceProviders = serviceProviders ?? []
            self.collectionView.reloadData()
        }
    }
}
