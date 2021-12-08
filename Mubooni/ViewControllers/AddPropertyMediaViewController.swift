import UIKit

class AddPropertyMediaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //viewUploadKenyaId.addDashedBorder()
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
        
    }
}
