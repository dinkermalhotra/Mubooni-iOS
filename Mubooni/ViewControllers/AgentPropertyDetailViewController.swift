import UIKit
import SDWebImage

class AgentPropertyDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var propertiesCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imgFirst: UIImageView!
    @IBOutlet weak var imgSecond: UIImageView!
    @IBOutlet weak var imgThird: UIImageView!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var lblThird: UILabel!
    @IBOutlet weak var lblPropertyPrice: UILabel!
    @IBOutlet weak var lblPropertyName: UILabel!
    @IBOutlet weak var lblPropertyLocation: UILabel!
    @IBOutlet weak var lblPropertyDescription: UILabel!
    
    @IBOutlet weak var btnBookShortStay: UIButton!
    @IBOutlet weak var btnInquiry: UIButton!
    
    var property: Properties?
    var propertyImages = [AppAttachments]()
    
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
        setData()
        
        if settings?.userProfile == nil {
            btnInquiry.isHidden = false
            
            for unit in property?.units ?? [] {
                if unit.unitStatus.lowercased() == Strings.SHORT_STAY.lowercased() {
                    btnBookShortStay.isHidden = false
                    break
                }
            }
        }
    }
    
    func setupCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: AppConstants.PORTRAIT_SCREEN_WIDTH - 32, height: collectionView.frame.size.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        let propertiesLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        propertiesLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        propertiesLayout.itemSize = CGSize(width: 70, height: propertiesCollectionView.frame.size.height)
        propertiesLayout.minimumInteritemSpacing = 0
        propertiesLayout.minimumLineSpacing = 0
        propertiesLayout.scrollDirection = .horizontal
        propertiesCollectionView.collectionViewLayout = propertiesLayout
    }
    
    func setData() {
        lblPropertyDescription.text = property?.ownerNotes ?? ""
        lblPropertyLocation.text = property?.address ?? ""
        lblPropertyName.text = property?.estateName ?? ""
        
        let unit = (property?.units.count ?? 0) > 0 ? property?.units[0] : nil
        lblPropertyPrice.text = unit?.unitStatus.lowercased() == Strings.UNIT_STATUS_SALE.lowercased() ? "\(Strings.SELLING_PRICE): \(Strings.KES)\(unit?.monthlyRent ?? "")" : "\(Strings.MONTHLY_RENT): \(Strings.KES)\(unit?.monthlyRent ?? "")"
        
        if property?.typeName.lowercased() == Strings.LAND.lowercased() {
            imgFirst.image = #imageLiteral(resourceName: "ic_unit_type")
                imgSecond.image = nil
            imgThird.image = nil
            
            lblFirst.text = property?.typeName ?? ""
            lblSecond.text = ""
            lblThird.text = ""
        }
        else {
            imgFirst.image = #imageLiteral(resourceName: "ic_bedroom")
            imgSecond.image = #imageLiteral(resourceName: "ic_bath")
            imgThird.image = #imageLiteral(resourceName: "ic_unit_type")
            
            lblFirst.text = (property?.units.count ?? 0) > 0 ? "\(property?.units[0].unitType == "1" ? "\(property?.units[0].unitType ?? "") \(Strings.BEDROOM)" : "\(property?.units[0].unitType ?? "") \(Strings.BEDROOMS)")" : ""
            lblSecond.text = (property?.units.count ?? 0) > 0 ? "\(property?.units[0].unitType == "1" ? "\(property?.units[0].unitType ?? "") \(Strings.BATH)" : "\(property?.units[0].unitType ?? "") \(Strings.BATHS)")" : ""
            lblThird.text = property?.typeName ?? ""
        }
        
        pageControl.numberOfPages = property?.app_Attachments.count ?? 0
        propertyImages = property?.app_Attachments ?? []
        collectionView.reloadData()
    }

}

// MARK: - UIBUTTON ACTIONS
extension AgentPropertyDetailViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookShortStayClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .BookShortStayViewController) as? BookShortStayViewController {
            vc.property = property
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func sendInquiryClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .InquirySubmissionViewController) as? InquirySubmissionViewController {
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

// MARK: - UICOLLECTIONVIEW METHODS
extension AgentPropertyDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == propertiesCollectionView {
            return property?.units.count ?? 0
        }
        else {
            return propertyImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == propertiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.PropertyUnitsCell, for: indexPath) as! PropertyUnitsCell
            
            let dict = property?.units[indexPath.row]
            
            cell.lblBedroom.text = dict?.unitType ?? ""
            cell.lblUnitNumber.text = dict?.unitNumber ?? ""
            cell.lblPropertyFor.text = dict?.unitStatus ?? ""
            cell.lblArea.text = dict?.area ?? ""
            cell.lblAreaType.text = dict?.areaType ?? ""
            cell.imgShortStay.image = (dict?.checkShortStay ?? "") == Strings.ONE ? UIImage(named: "ic_verified") : UIImage(named: "ic_unverified")
            cell.lblPrice.text = dict?.monthlyRent ?? ""
            cell.lblShortStayPrice.text = (dict?.checkShortStay ?? "") == Strings.ONE ? "\(dict?.perDay ?? "")/\(Strings.PER_DAY)" : ""
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.ImagesCell, for: indexPath) as! ImagesCell
            
            let dict = propertyImages[indexPath.row]
            
            let block: SDExternalCompletionBlock? = {(image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) -> Void in
                //print(image)
                if (image == nil) {
                    return
                }
            }
            
            if let url = URL(string: "\(WebService.baseImageUrl)\(dict.img)") {
                cell.imgProperty.sd_setImage(with: url, completed: block)
            }
            
            return cell
        }
    }
}

// MARK: - UISCROLLVIEW DELEGATE
extension AgentPropertyDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.currentPage = pageNumber
    }
}
