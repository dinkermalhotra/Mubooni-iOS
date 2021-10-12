import UIKit

class IntroScreensViewController: UIViewController {

    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewOneWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewTwoWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewThree: UIView!
    @IBOutlet weak var viewThreeWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [#imageLiteral(resourceName: "ic_sliding_image1"), #imageLiteral(resourceName: "ic_sliding_image2"), #imageLiteral(resourceName: "ic_sliding_image3")]
    var header = ["Quick contact with", "Best way to explore", "Search for home"]
    var subHeader = ["Service Provider", "property and location", "Sell, Rent or Buy"]
    var details = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida. Risus commodo.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida. Risus commodo.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida. Risus commodo."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: AppConstants.PORTRAIT_SCREEN_WIDTH, height: collectionView.frame.size.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - UIBUTTON ACTIONS
extension IntroScreensViewController {
    @IBAction func getStartedClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .MainViewController) as? MainViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UICOLLECTIONVIEW METHODS
extension IntroScreensViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.IntroScreensCell, for: indexPath) as! IntroScreensCell
        
        cell.imgHeader.image = images[indexPath.row]
        cell.lblHeader.text = header[indexPath.row]
        cell.lblSubHeader.text = subHeader[indexPath.row]
        cell.lblDetail.text = details[indexPath.row]
        
        return cell
    }
}

// MARK: - UISCROLLVIEW DELEGATE
extension IntroScreensViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        print(pageNumber)
        
        if pageNumber == 0 {
            viewOne.backgroundColor = MubooniColors.darkGreenColor
            viewTwo.backgroundColor = MubooniColors.blackTransparentColor
            viewThree.backgroundColor = MubooniColors.blackTransparentColor
            
            viewOneWidthConstraint.constant = 60
            viewTwoWidthConstraint.constant = 20
            viewThreeWidthConstraint.constant = 20
        }
        else if pageNumber == 1 {
            viewOne.backgroundColor = MubooniColors.blackTransparentColor
            viewTwo.backgroundColor = MubooniColors.darkGreenColor
            viewThree.backgroundColor = MubooniColors.blackTransparentColor
            
            viewOneWidthConstraint.constant = 20
            viewTwoWidthConstraint.constant = 60
            viewThreeWidthConstraint.constant = 20
        }
        else if pageNumber == 2 {
            viewOne.backgroundColor = MubooniColors.blackTransparentColor
            viewTwo.backgroundColor = MubooniColors.blackTransparentColor
            viewThree.backgroundColor = MubooniColors.darkGreenColor
            
            viewOneWidthConstraint.constant = 20
            viewTwoWidthConstraint.constant = 20
            viewThreeWidthConstraint.constant = 60
        }
    }
}
