//
//  ChartViewController.swift
//  Vortex Mortgage
//
//  Created by Christian Lorenzo on 6/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {
    
    let pieChartView = PieChartView()
    var myNewHomePrice: Float = 0.00
    var myNewDownPayment: Float = 0.00
    var myNewInterestRate: Float = 0.00
    var loanTerm1: Float = 0.00
    var downPaymentMinusHomePrice: Float = 0.00
    var loanTerm: Float = 0.00
    var myScheduledPayments: [[Float]] = [[]]
    //Computed Properties:
    var loanAmount: Float {
        downPaymentMinusHomePrice
    }
    
    var loanAmountWithTerm: Float { //Monthly Payment without interest
        loanAmount / loanTerm
    }
    
    var interestAmountInCurrency: Float { //Interest calulation based on loan amount.
        (loanAmount * myNewInterestRate) / 100
    }
    
    var interestDividedByTerm: Float {
        interestAmountInCurrency / loanTerm
    }
    
    var totalMonthlyPayment: Float = 0.00
    
    
    //Outlets:
    @IBOutlet weak var imageView1: UIView!
    @IBOutlet weak var totalMonthlyLabel: UILabel!
    @IBOutlet weak var homePriceLabel: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var dpwnPaymentLabel: UILabel!
    @IBOutlet weak var downPaymentPercentageLabel: UILabel!
    @IBOutlet weak var downPaymentSlider: UISlider!
    @IBOutlet weak var interestPercentageLabel: UILabel!
    @IBOutlet weak var interestPercentageSlider: UISlider!
    @IBOutlet weak var downPaymentSign: UILabel!
    @IBOutlet weak var interestPercentageSign: UILabel!
    @IBOutlet weak var homePriceSign: UILabel!
    @IBOutlet weak var termSignLabel: UILabel!
    @IBOutlet weak var termAmountLabel: UILabel!
    @IBOutlet weak var termSlider: UISlider!
    @IBOutlet weak var calculatePaymentOutlet: UIButton!
    
    //Actions:
    @IBAction func amountSlider(_ sender: UISlider) {
        updateSegment()
        
        let homePrice = String(format: "%.2f", sender.value)
        homePriceLabel.text = "$\(homePrice)"
        myNewHomePrice = Float(homePrice)!
    }
    
    
    @IBAction func downPaymentSliderChanged(_ sender: UISlider) {
        updateSegment()
        
        let downPaymentPercentage = String(format: "%.0f", sender.value)
        downPaymentPercentageLabel.text = "\(downPaymentPercentage)%"
        myNewDownPayment = Float(downPaymentPercentage)!
        
        let downPaymentAmount = (myNewHomePrice * myNewDownPayment) / 100
        dpwnPaymentLabel.text = "$\(downPaymentAmount)"
        downPaymentMinusHomePrice = myNewHomePrice - downPaymentAmount
    }
    
    
    @IBAction func interestPercetangeSliderChanged(_ sender: UISlider) {
        updateSegment()
        
        let interestRate = String(format: "%.2f", sender.value)
        interestPercentageLabel.text = "\(interestRate)%"
        myNewInterestRate = Float(interestRate)!
    }
    
    
    @IBAction func termSliderChanged(_ sender: UISlider) {
        updateSegment()
        
        let loanTermLabel = String(format: "%.0f", sender.value)
        termAmountLabel.text = "\(loanTermLabel)"
        loanTerm1 = Float(loanTermLabel)!
        loanTerm = loanTerm1 * 12
    }
    
    @IBAction func calculatePaymentTapped(_ sender: UIButton) {
        guard loanTerm >= 1.0 else { return }
        
        totalMonthlyPayment = getMonthlyPayment(loanAmount: loanAmount, termMonth: loanTerm, interestRate: myNewInterestRate)
        let roundedResult = totalMonthlyPayment.rounded(toPlaces: 2)
        totalMonthlyLabel.text = "Monthly Payment: $\(roundedResult)"
        
        myScheduledPayments = getPaymentSchedule(loanAmount: loanAmount, termMonth: Int(loanTerm), interestRate: myNewInterestRate)
    }
    
    @IBAction func returnHome(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
       }
       
    
    
    func getMonthlyPayment(loanAmount: Float, termMonth: Float, interestRate: Float) -> Float {
        let r : Float = interestRate / (100 * 12)
        let m : Float = Float(termMonth)
        let l : Float = loanAmount
        let payment : Float = l * (r * pow((1 + r), m)) / (pow((1 + r), m) - 1)
        return payment
    }
    
    func getPaymentSchedule(loanAmount: Float, termMonth: Int, interestRate: Float) -> [[Float]] {
        let r : Float = interestRate / (100 * 12)
        let monthlyPayment = getMonthlyPayment(loanAmount: loanAmount, termMonth: loanTerm, interestRate: myNewInterestRate)
        var totalInterest: Float = 0
        var remainingBalance = loanAmount
        var scheduleArray : [[Float]] = []
        
        for m in 1...termMonth {
            let interest = remainingBalance * r
            let principal = monthlyPayment - interest
            totalInterest += interest
            remainingBalance -= principal
            scheduleArray += [[interest, principal, remainingBalance]]
        }
        
        return scheduleArray
    }

    
    
    func updateSegment() {
        pieChartView.segments = [
            LabelledSegment(color: #colorLiteral(red: 1.0, green: 0.121568627, blue: 0.28627451, alpha: 1.0), name: "Interest %", value: CGFloat(interestPercentageSlider.value * priceSlider.value / 100)),
            LabelledSegment(color: #colorLiteral(red: 1.0, green: 0.541176471, blue: 0.0, alpha: 1.0), name: "Loan Value", value: CGFloat(downPaymentMinusHomePrice)),
            //LabelledSegment(color: #colorLiteral(red: 0.478431373, green: 0.423529412, blue: 1.0, alpha: 1.0), name: "Purple",     value: 0),
            LabelledSegment(color: #colorLiteral(red: 0.0, green: 0.870588235, blue: 1.0, alpha: 1.0), name: "Loan Term", value: CGFloat(termSlider.value * 12)),
            //LabelledSegment(color: #colorLiteral(red: 0.392156863, green: 0.945098039, blue: 0.717647059, alpha: 1.0), name: "Green",      value: 0),
            LabelledSegment(color: #colorLiteral(red: 0.0, green: 0.392156863, blue: 1.0, alpha: 1.0), name: "Down Pmt",   value: CGFloat(downPaymentSlider.value * priceSlider.value / 100))
        ]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateSegment()
        //totalMonthly()
        
        let padding: CGFloat = 100
        let height = (view.frame.height - padding * 3) / 2.5
        
        pieChartView.frame = imageView1.bounds
        pieChartView.segmentLabelFont = .systemFont(ofSize: 10)
        
        //Code for Label Border:
        homePriceSign.layer.borderColor = UIColor.black.cgColor
        homePriceSign.layer.borderWidth = 1.0
        homePriceSign.layer.cornerRadius = 5
        homePriceSign.clipsToBounds = true
        //homePriceSign.backgroundColor = UIColor.systemOrange
        
        homePriceLabel.layer.borderColor = UIColor.black.cgColor
        homePriceLabel.layer.borderWidth = 1.0
        homePriceLabel.layer.cornerRadius = 5
        homePriceLabel.clipsToBounds = true
        
        downPaymentSign.layer.borderColor = UIColor.black.cgColor
        downPaymentSign.layer.borderWidth = 1.0
        downPaymentSign.layer.cornerRadius = 5
        downPaymentSign.clipsToBounds = true
        
        downPaymentPercentageLabel.layer.borderColor = UIColor.black.cgColor
        downPaymentPercentageLabel.layer.borderWidth = 1.0
        downPaymentPercentageLabel.layer.cornerRadius = 5
        downPaymentPercentageLabel.clipsToBounds = true
        
        dpwnPaymentLabel.layer.borderColor = UIColor.black.cgColor
        dpwnPaymentLabel.layer.borderWidth = 1.0
        dpwnPaymentLabel.layer.cornerRadius = 5
        dpwnPaymentLabel.clipsToBounds = true
        
        interestPercentageSign.layer.borderColor = UIColor.black.cgColor
        interestPercentageSign.layer.borderWidth = 1.0
        interestPercentageSign.layer.cornerRadius = 5
        interestPercentageSign.clipsToBounds = true
        
        interestPercentageLabel.layer.borderColor = UIColor.black.cgColor
        interestPercentageLabel.layer.borderWidth = 1.0
        interestPercentageLabel.layer.cornerRadius = 5
        interestPercentageLabel.clipsToBounds = true
        
        termSignLabel.layer.borderColor = UIColor.black.cgColor
        termSignLabel.layer.borderWidth = 1.0
        termSignLabel.layer.cornerRadius = 5
        termSignLabel.clipsToBounds = true
        
        termAmountLabel.layer.borderColor = UIColor.black.cgColor
        termAmountLabel.layer.borderWidth = 1.0
        termAmountLabel.layer.cornerRadius = 5
        termAmountLabel.clipsToBounds = true
        
        //Constraints code:
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        imageView1.addSubview(pieChartView)
        NSLayoutConstraint.activate([
            imageView1.leadingAnchor.constraint(equalTo: pieChartView.leadingAnchor),
            imageView1.trailingAnchor.constraint(equalTo: pieChartView.trailingAnchor),
            imageView1.topAnchor.constraint(equalTo: pieChartView.topAnchor),
            imageView1.bottomAnchor.constraint(equalTo: pieChartView.bottomAnchor)
        ])
        
        //Constraints for the totalMonthlyLabel:
        totalMonthlyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalMonthlyLabel.leadingAnchor.constraint(equalTo: imageView1.leadingAnchor),
            totalMonthlyLabel.trailingAnchor.constraint(equalTo: imageView1.trailingAnchor),
            totalMonthlyLabel.topAnchor.constraint(equalTo: imageView1.bottomAnchor)
        ])
        
        //Constraints for the loanOutlet label:
        homePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homePriceLabel.widthAnchor.constraint(equalToConstant: 140),
            homePriceLabel.topAnchor.constraint(equalTo: totalMonthlyLabel.bottomAnchor, constant: 8),
            homePriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: homePriceSign.trailingAnchor, constant: 8),
            homePriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        homePriceSign.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homePriceSign.widthAnchor.constraint(equalToConstant: 125),
            homePriceSign.topAnchor.constraint(equalTo: totalMonthlyLabel.bottomAnchor, constant: 8),
            homePriceSign.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            homePriceSign.trailingAnchor.constraint(equalTo: homePriceLabel.leadingAnchor, constant: -90),
        ])
        
        //Constraints for the price slider:
        priceSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceSlider.topAnchor.constraint(equalTo: homePriceLabel.bottomAnchor, constant: 12),
            priceSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            priceSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        //Constraints for downPayment Label:
        dpwnPaymentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dpwnPaymentLabel.widthAnchor.constraint(equalToConstant: 125),
            dpwnPaymentLabel.topAnchor.constraint(equalTo: priceSlider.bottomAnchor, constant: 30),
            dpwnPaymentLabel.leadingAnchor.constraint(greaterThanOrEqualTo: downPaymentPercentageLabel.trailingAnchor, constant: 20),
            dpwnPaymentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        downPaymentSign.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downPaymentSign.widthAnchor.constraint(equalToConstant: 125),
            downPaymentSign.topAnchor.constraint(equalTo: priceSlider.bottomAnchor, constant: 30),
            downPaymentSign.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            downPaymentSign.trailingAnchor.constraint(equalTo: downPaymentPercentageLabel.leadingAnchor, constant: -14)
        ])
        
        downPaymentPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downPaymentPercentageLabel.widthAnchor.constraint(equalToConstant: 58),
            downPaymentPercentageLabel.topAnchor.constraint(equalTo: priceSlider.bottomAnchor, constant: 30),
            downPaymentPercentageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            downPaymentPercentageLabel.trailingAnchor.constraint(equalTo: dpwnPaymentLabel.leadingAnchor, constant: -20)
        ])
        
        downPaymentSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downPaymentSlider.topAnchor.constraint(equalTo: downPaymentSign.bottomAnchor, constant: 12),
            downPaymentSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            downPaymentSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        interestPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            interestPercentageLabel.widthAnchor.constraint(equalToConstant: 140),
            interestPercentageLabel.topAnchor.constraint(equalTo: downPaymentSlider.bottomAnchor, constant: 30),
            interestPercentageLabel.leadingAnchor.constraint(equalTo: interestPercentageSign.trailingAnchor),
            interestPercentageLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        interestPercentageSign.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            interestPercentageSign.widthAnchor.constraint(equalToConstant: 125),
            interestPercentageSign.topAnchor.constraint(equalTo: downPaymentSlider.bottomAnchor, constant: 30),
            interestPercentageSign.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            interestPercentageSign.trailingAnchor.constraint(equalTo: interestPercentageLabel.leadingAnchor, constant: -91)
        ])
        
        interestPercentageSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            interestPercentageSlider.topAnchor.constraint(equalTo: interestPercentageLabel.bottomAnchor, constant: 12),
            interestPercentageSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            interestPercentageSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        termAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            termAmountLabel.widthAnchor.constraint(equalToConstant: 155),
            termAmountLabel.topAnchor.constraint(equalTo: interestPercentageSlider.bottomAnchor, constant: 30),
            termAmountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: termSignLabel.trailingAnchor, constant: 8),
            termAmountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        termSignLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            termSignLabel.widthAnchor.constraint(equalToConstant: 125),
            termSignLabel.topAnchor.constraint(equalTo: interestPercentageSlider.bottomAnchor, constant: 30),
            termSignLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        termSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            termSlider.topAnchor.constraint(equalTo: termSignLabel.bottomAnchor, constant: 12),
            termSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            termSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        calculatePaymentOutlet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calculatePaymentOutlet.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 2),
            calculatePaymentOutlet.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            calculatePaymentOutlet.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! PaymentScheduleTableViewController
            destinationVC.loanAmount = self.loanAmount
            destinationVC.loanTerm = self.loanTerm
            destinationVC.myNewInterestRate = self.myNewInterestRate
            destinationVC.myScheduledPayments = self.myScheduledPayments
        }
    }
}


extension Float {
    func rounded(toPlaces places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
