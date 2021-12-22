import UIKit

class TenantListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var tenants = [Tenants]()
    
    var _settings: SettingsManager?
    
    var settings: SettingsManagerProtocol?
    {
        if let _ = WSManager._settings {
        }
        else {
            WSManager._settings = SettingsManager()
        }

        return WSManager._settings
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionViewLayout()
        
        Helper.showLoader(onVC: self)
        fetchTenants()
    }
    
    func setupCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: AppConstants.PORTRAIT_SCREEN_WIDTH / 2 - 24, height: 106)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - UIBUTTON ACTIONS
extension TenantListViewController {
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICOLLECTIONVIEW METHODS
extension TenantListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tenants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.TenantListCell, for: indexPath as IndexPath) as! TenantListCell
        
        let dict = tenants[indexPath.row]
        
        cell.lblTenantName.text = dict.tenantName
        cell.lblUnitNumber.text = "Unit No: \(dict.unitNumber)"
        cell.lblPropertyAddress.text = dict.propertyAddress
        cell.lblPropertyName.text = dict.email
        
        return cell
    }
}

// MARK: - API CALL
extension TenantListViewController {
    func fetchTenants() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_LOG_USERID: settings?.userProfile?.userId as AnyObject]
        WSManager.wsCallGetAgentTenants(params) { isSuccess, message, tenants in
            Helper.hideLoader(onVC: self)
            
            self.tenants = tenants ?? []
            self.collectionView.reloadData()
        }
    }
}
