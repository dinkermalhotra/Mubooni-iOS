import UIKit

class TenantListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var userProfile: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionViewLayout()
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.TenantListCell, for: indexPath as IndexPath) as! TenantListCell
        
        return cell
    }
}

// MARK: - API CALL
extension TenantListViewController {
    
}
