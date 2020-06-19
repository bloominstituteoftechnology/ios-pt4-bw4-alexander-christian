//
//  ResultsViewController.swift
//  Vortex Mortgage
//
//  Created by Christian Lorenzo on 6/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var totalAmount: Float?
    var totalInterest: Float?
    var totalYearsTerm: Float?
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var totalInterestLabel: UILabel!
    @IBOutlet weak var totalAmountTerm: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("Result"), object: nil)
        if let total = totalAmount {
            let myNewtotal = String(format: "%.2f", total)
            resultLabel.text = "$\(myNewtotal)"
        }
        
        if let myTotalInterest = totalInterest {
            let myNewTotalInterest = String(format: "%.2f", myTotalInterest)
            totalInterestLabel.text = "$\(myNewTotalInterest)"
        }
        
        if let myTotalTerm = totalYearsTerm {
            let myNewTotalTerm = String(format: "%.0f", myTotalTerm)
            totalAmountTerm.text = "\(myNewTotalTerm)"
        }
        
    }
    
    
    @objc func didGetNotification(_ notification: Notification) {
        let totalAmount = notification.object as! String?
        resultLabel.text = totalAmount
    }
    
    
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
