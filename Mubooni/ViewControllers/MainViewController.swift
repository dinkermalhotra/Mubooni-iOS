import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var featuredCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var featuredPropertiesCollectionView: UICollectionView!
    
    var categories = [UIImage(named: "f5.png"), UIImage(named: "f6.png"), UIImage(named: "f8.png")]
    var properties = [UIImage(named: "f8.png"), UIImage(named: "f6.png"), UIImage(named: "f5.png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: AppConstants.PORTRAIT_SCREEN_WIDTH, height: featuredCategoriesCollectionView.frame.size.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        featuredCategoriesCollectionView.collectionViewLayout = layout
        featuredPropertiesCollectionView.collectionViewLayout = layout
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
        if collectionView == featuredCategoriesCollectionView {
            return categories.count
        }
        else {
            return properties.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.MainFeaturedCell, for: indexPath) as! MainFeaturedCell
        
        if collectionView == featuredCategoriesCollectionView {
            cell.imgProperty.image = categories[indexPath.row]
        }
        else {
            cell.imgProperty.image = properties[indexPath.row]
        }
        
        return cell
    }
}
