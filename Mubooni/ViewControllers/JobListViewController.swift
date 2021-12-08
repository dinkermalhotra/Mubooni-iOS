import UIKit

class JobListViewController: UIViewController {
   
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var userProfile: UserProfile?
    var jobs = [Jobs]()
    var requests = [Jobs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentControl()
        
        Helper.showLoader(onVC: self)
        fetchJobs()
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
        self.tableView.reloadData()
    }
}

// MARK: - UITABLEVIEW METHODS
extension JobListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return requests.count
        }
        else {
            return jobs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.JobListCell, for: indexPath) as! JobListCell
        
        var dict: Jobs?
        
        if segmentControl.selectedSegmentIndex == 0 {
            dict = requests[indexPath.row]
        }
        else {
            dict = jobs[indexPath.row]
        }
        
        cell.lblPropertyName.text = dict?.estateName ?? ""
        cell.lblPropertyAddress.text = dict?.address ?? ""
        cell.lblDescription.text = dict?.problemDescription ?? ""
        cell.lblType.text = dict?.jobStatus == Strings.ZERO ? Strings.TENANT : Strings.SERVICE_PROVIDER
        cell.imgType.image = dict?.jobStatus == Strings.ZERO ? UIImage(named: "ic_tenant_green") : UIImage(named: "ic_service_provide_red")
        
        return cell
    }
}

// MARK: - API CALL
extension JobListViewController {
    func fetchJobs() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_LOG_USERID: userProfile?.userId as AnyObject, WSRequestParams.WS_REQS_PARAM_PAGE_TYPE: "" as AnyObject]
        WSManager.wsCallGetAgentJobs(params) { isSuccess, message, jobs in
            self.fetchRequests()
            
            self.jobs = jobs?.filter({ value in
                value.jobStatus != Strings.ZERO
            }) ?? []
        }
    }
    
    func fetchRequests() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_LOG_USERID: userProfile?.userId as AnyObject, WSRequestParams.WS_REQS_PARAM_PAGE_TYPE: "" as AnyObject]
        WSManager.wsCallGetAgentJobs(params) { isSuccess, message, jobs in
            Helper.hideLoader(onVC: self)
            
            self.requests = jobs ?? []
            self.tableView.reloadData()
        }
    }
}
