import UIKit

class ServiceReportViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    var userProfile: UserProfile?
    var reports = [PaymentReports]()
    var totalPaid = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Helper.showLoader(onVC: self)
        fetchReports()
    }

}

// MARK: - UIBUTTON ACTIONS
extension ServiceReportViewController {
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITABLEVIEW METHODS
extension ServiceReportViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.ServiceReportCell, for: indexPath) as! ServiceReportCell
        
        let dict = reports[indexPath.row]
        
        cell.lblDescription.text = dict.problemDescription
        cell.lblName.text = dict.name
        cell.lblPrice.text = "$\(dict.amount)"
        cell.lblDate.text = Helper.convertReportDate(dict.paidDate)
        cell.lblYear.text = Helper.convertReportYear(dict.paidDate)
        
        return cell
    }
}

// MARK: - API CALL
extension ServiceReportViewController {
    func fetchReports() {
        let params: [String: AnyObject] = [WSRequestParams.WS_REQS_PARAM_LOG_USERID: userProfile?.userId as AnyObject]
        WSManager.wsCallGetAgentPaymentReports(params) { isSuccess, message, paymentReports in
            Helper.hideLoader(onVC: self)
            
            for report in paymentReports ?? [] {
                let amount = Double(report.amount) ?? 0.0
                self.totalPaid = self.totalPaid + amount
            }
            
            self.lblTotalPrice.text = "$\(self.totalPaid)"
            self.reports = paymentReports ?? []
            self.tableView.reloadData()
        }
    }
}
