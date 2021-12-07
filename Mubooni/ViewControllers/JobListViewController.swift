import UIKit

class JobListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var userProfile: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    
        if #available(iOS 13.0, *) {
            segmentControl.selectedSegmentTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
    }

    @available(iOS 13.0, *)
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            print("0")
            if #available(iOS 13.0, *) {
                segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                segmentControl.selectedSegmentTintColor = UIColor.blue
            } else {
                segmentControl.tintColor = UIColor.blue
            }
            segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            segmentControl.selectedSegmentTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case 1:
            print("1")
            segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            segmentControl.selectedSegmentTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        default:
            break;
        }
        
    }
// MARK: - TABLE VIEW DELEGATE METHOD
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.JobListCell, for: indexPath as IndexPath) as! JobListCell

    return cell
}
}

// MARK: - UIBUTTON ACTIONS
extension JobListViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
