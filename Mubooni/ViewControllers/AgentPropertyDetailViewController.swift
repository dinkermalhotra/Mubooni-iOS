import UIKit

class AgentPropertyDetailViewController: UIViewController {

    @IBOutlet weak var lblPropertyName: UILabel!
    @IBOutlet weak var lblPropertyLocation: UILabel!
    
    var property: Properties?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }
    
    func setData() {
        lblPropertyName.text = property?.estateName ?? ""
        lblPropertyLocation.text = property?.address ?? ""
    }

}

// MARK: - UIBUTTON ACTIONS
extension AgentPropertyDetailViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
