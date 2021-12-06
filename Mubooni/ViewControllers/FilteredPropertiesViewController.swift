import UIKit
import SDWebImage

class FilteredPropertiesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var filteredProperties = [Properties]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionViewLayout()
    }
    
    func setupCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: AppConstants.PORTRAIT_SCREEN_WIDTH, height: 240)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - UIBUTTON ACTIONS
extension FilteredPropertiesViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        for controller in (self.navigationController?.viewControllers ?? [UIViewController]()) {
            if controller.isKind(of: MainViewController.self) {
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func filtersClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICOLLECTIONVIEW METHODS
extension FilteredPropertiesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProperties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.MainFeaturedCell, for: indexPath) as! MainFeaturedCell
        
        let block: SDExternalCompletionBlock? = {(image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) -> Void in
            //print(image)
            if (image == nil) {
                return
            }
        }

        let dict = filteredProperties[indexPath.row]
        
        if let url = URL(string: dict.app_Attachments.count > 0 ? "\(WebService.baseImageUrl)\(dict.app_Attachments[0].img)" : "") {
            cell.imgProperty.sd_setImage(with: url, completed: block)
        }
        
        cell.lblLocation.text = dict.address
        
        let unit = dict.units.count > 0 ? dict.units[0] : nil
        cell.lblPrice.text = unit?.unitStatus.lowercased() == Strings.UNIT_STATUS_SALE.lowercased() ? "\(Strings.SELLING_PRICE): \(Strings.KES)\(unit?.monthlyRent ?? "")" : "\(Strings.MONTHLY_RENT): \(Strings.KES)\(unit?.monthlyRent ?? "")"
        
        return cell
    }
}
