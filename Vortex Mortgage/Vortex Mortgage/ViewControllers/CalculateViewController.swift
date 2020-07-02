//
//  CalculateViewController.swift
//  Vortex Mortgage
//
//  Created by Christian Lorenzo on 6/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

struct CalcValue {
    let value: Float
}

class CalculateViewController: UIViewController {
    
    var totalAmount: Float = 0
    
    //Outlets:
    @IBOutlet weak var homePriceTextField: UITextField!
    @IBOutlet weak var downPaymentTextField: UITextField!
    @IBOutlet weak var mortgageTermLabel: UILabel!
    @IBOutlet weak var mortgageTermSlider: UISlider!
    @IBOutlet weak var mortgageInterestLabel: UILabel!
    @IBOutlet weak var mortgageInterestSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //Sliders - Action:
    
    @IBAction func mortageTermSliderChanged(_ sender: UISlider) {
        let numberOfYears = String(format: "%.0f", sender.value)
        mortgageTermLabel.text = "\(numberOfYears)Year/s"
    }
    
    @IBAction func interestRateSliderChanged(_ sender: UISlider) {
        let interestRate = String(format: "%.2f", sender.value)
        mortgageInterestLabel.text = "\(interestRate)%"
    }
    
    @IBAction func returnHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func calculatePaymentPressed(_ sender: UIButton) {
        guard let homeValue = homePriceTextField.text, !homeValue.isEmpty, let homeValueNumber = Float(homeValue) else { return }
        guard let downPayment = downPaymentTextField.text, !downPayment.isEmpty, let downPaymentNumber = Float(downPayment) else { return }
        let mortgageTermSliderAmount = mortgageTermSlider.value
        let mortgageInterestRateAmount = mortgageInterestSlider.value
        
        let totalLoan = homeValueNumber - downPaymentNumber
        let calculateInterest = mortgageInterestRateAmount / 100 / 1.5 * totalLoan
        
        let totalAmountLoan = calculateInterest * mortgageInterestRateAmount + totalLoan
        //let currencyConversion = convertFloatToCurrency(amount: totalAmountLoan)
        totalAmount = totalAmountLoan
        
        //NotificationCenter.default.post(name: Notification.Name("Result"), object: totalAmount)
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    
    //Functions:
    func hideKeyBoard() {
        homePriceTextField.resignFirstResponder()
        downPaymentTextField.resignFirstResponder()
    }
    
    func convertFloatToCurrency(amount: Float) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        
        return numberFormatter.string(from: NSNumber(value: amount))!
    }
    
    
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToResults" {
//            let destinationVC = segue.destination as! UINavigationController
//            let topResultsVC = destinationVC.topViewController as! ResultsViewController
//            //destinationVC.incomingValue = CalcValue.init(value: totalAmountLoan) //totalResult
//            topResultsVC.totalAmount = self.totalAmount
//        }
//    }
}
