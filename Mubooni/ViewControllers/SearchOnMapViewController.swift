import UIKit

class SearchOnMapViewController: UIViewController {

    @IBOutlet weak var viewSearch: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSearch.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(searchClicked)))
    }

    @objc func searchClicked() {
        
    }
}

// MARK: - UIBUTTON ACTIONS
extension SearchOnMapViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
