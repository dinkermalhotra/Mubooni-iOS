import UIKit
import SDWebImage

class ServiceProviderDetailViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSpecialisation: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblSuccessfulJobs: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    
    var userProfile: UserProfile?
    var serviceProvider: ServiceProviders?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }

    func setData() {
        let block: SDExternalCompletionBlock? = {(image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) -> Void in
            //print(image)
            if (image == nil) {
                return
            }
        }
        
        if let url = URL(string: "\(WebService.baseImageUrl)\(serviceProvider?.profile ?? "")") {
            imgProfile.sd_setImage(with: url, completed: block)
        }

        lblName.text = serviceProvider?.name ?? ""
        lblSpecialisation.text = serviceProvider?.specialisations ?? ""
        lblAddress.text = serviceProvider?.address ?? ""
        lblAbout.text = serviceProvider?.about ?? ""
    }
}

// MARK: - UIBUTTON ACTIONS
extension ServiceProviderDetailViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startChatClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func assignJobClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func contactClicked(_ sender: UIButton) {
        if let url = URL(string: "tel://\(serviceProvider?.mobile ?? "")"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
