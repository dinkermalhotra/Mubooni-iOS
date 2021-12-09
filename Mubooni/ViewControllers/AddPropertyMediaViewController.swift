import UIKit

class AddPropertyMediaViewController: UIViewController {

    @IBOutlet weak var viewSelectImage: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var propertyImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionViewLayout()
        
        viewSelectImage.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleViewSelectImagesTap)))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        viewSelectImage.addDashedBorder()
    }
    
    func setupCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: AppConstants.PORTRAIT_SCREEN_WIDTH / 2 - 16, height: collectionView.frame.size.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
    
    @objc func handleViewSelectImagesTap() {
        Helper.showActionAlert(onVC: self, title: Alert.CHOOSE, titleOne: Strings.TAKE_PHOTO, actionOne: takeNewPhotoFromCamera, titleTwo: Strings.CHOOSE_PHOTO, actionTwo: choosePhotoFromExistingImages)
    }
}

// MARK: - UIBUTTON ACTIONS
extension AddPropertyMediaViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func previousClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .AddPropertyDetailsViewController) as? AddPropertyDetailsViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func removeClicked(_ sender: UIButton) {
        propertyImages.remove(at: sender.tag)
        collectionView.reloadData()
    }
}

// MARK: - UIIMAGEPICKERCONTROLLER DELEGAT
extension AddPropertyMediaViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takeNewPhotoFromCamera() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.SourceType.camera
        self.present(picker, animated: true, completion: nil)
    }
    
    func choosePhotoFromExistingImages() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        DispatchQueue.main.async {
            self.propertyImages.append(editedImage)
            self.collectionView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICOLLECTIONVIEW METHODS
extension AddPropertyMediaViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return propertyImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.AddPropertyImageCell, for: indexPath) as! AddPropertyImageCell
        
        cell.imgProperty.image = propertyImages[indexPath.row]
        
        cell.btnRemove.tag = indexPath.row
        cell.btnRemove.addTarget(self, action: #selector(removeClicked(_:)), for: .touchUpInside)
        
        return cell
    }
}
