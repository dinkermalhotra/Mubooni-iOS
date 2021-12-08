//
//  ServiceReportViewController.swift
//  Mubooni
//
//  Created by krishna41 on 07/12/21.
//

import UIKit

class ServiceReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: TABLE VIEW DELEGATE METHOD
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.ServiceReportCell, for: indexPath) as! ServiceReportCell
        
        return cell
    }
    

}
