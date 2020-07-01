//
//  PaymentScheduleTableViewController.swift
//  Vortex Mortgage
//
//  Created by Christian Lorenzo on 6/29/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class PaymentScheduleTableViewController: UITableViewController {
    
    var loanAmount: Float = 0.00
    var loanTerm: Float = 0.00
    var myNewInterestRate: Float = 0.00
    var myScheduledPayments: [[Float]] = [[]]
    var chartViewController = ChartViewController()
    var paymentScheduleHeaderView = PaymentScheduleHeaderView()
    
//    var myItems: [[String]] = [["Ferrari", "Toyota", "Ford"], ["Chevy", "Cheri", "Infinity"], ["Ferrari", "Toyota", "Ford"], ["Chevy", "Cheri", "Infinity"], ["Ferrari", "Toyota", "Ford"], ["Chevy", "Cheri", "Infinity"], ["Ferrari", "Toyota", "Ford"], ["Chevy", "Cheri", "Infinity"], ["Ferrari", "Toyota", "Ford"], ["Chevy", "Cheri", "Infinity"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let headerNib = UINib.init(nibName: "PaymentScheduleHeaderView", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "PaymentScheduleHeaderView")
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myScheduledPayments.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PaymentScheduleHeaderView") as! PaymentScheduleHeaderView
        
        //headerView.interestLabel.text = "My Cars"
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! PaymentScheduleTableViewCell

        // Configure the cell...
        let myArray = self.myScheduledPayments[indexPath.row]
        cell.InterestInfoLabel.text = "\(myArray[0])"
        cell.principalInfoLabel.text = "\(myArray[1])"
        cell.remainingInfoLabel.text = "\(myArray[2])"
        
        if myArray[2] <= 0 {
            cell.remainingInfoLabel.text = "0"
        }

        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
