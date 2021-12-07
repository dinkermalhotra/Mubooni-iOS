import UIKit

class JobListViewController: UIViewController {
   
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var userProfile: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentControl()
    }
    
    func setupSegmentControl() {
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: MubooniFonts.FONT_ROBOTO_REGULAR_16 ?? UIFont.systemFont(ofSize: 16)], for: .selected)
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.black.withAlphaComponent(0.6), .font: MubooniFonts.FONT_ROBOTO_REGULAR_16 ?? UIFont.systemFont(ofSize: 16)], for: .normal)
    }
}

// MARK: - UIBUTTON ACTIONS
extension JobListViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        
    }
}

// MARK: - UITABLEVIEW METHODS
extension JobListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.JobListCell, for: indexPath) as! JobListCell
        
        return cell
    }
}
