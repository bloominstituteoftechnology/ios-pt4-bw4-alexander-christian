//
//  ChartViewController.swift
//  Vortex Mortgage
//
//  Created by Christian Lorenzo on 6/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {
    
    
    
    
    func updateSegment() {
        pieChartView.segments = [
            LabelledSegment(color: #colorLiteral(red: 1.0, green: 0.121568627, blue: 0.28627451, alpha: 1.0), name: "Interest %", value: CGFloat(interestPercentageSlider.value * priceSlider.value / 100)),
            LabelledSegment(color: #colorLiteral(red: 1.0, green: 0.541176471, blue: 0.0, alpha: 1.0), name: "Home Price", value: CGFloat((priceSlider.value))),
            //LabelledSegment(color: #colorLiteral(red: 0.478431373, green: 0.423529412, blue: 1.0, alpha: 1.0), name: "Purple",     value: 0),
            LabelledSegment(color: #colorLiteral(red: 0.0, green: 0.870588235, blue: 1.0, alpha: 1.0), name: "Light Blue", value: CGFloat(termSlider.value)),
            //LabelledSegment(color: #colorLiteral(red: 0.392156863, green: 0.945098039, blue: 0.717647059, alpha: 1.0), name: "Green",      value: 0),
            LabelledSegment(color: #colorLiteral(red: 0.0, green: 0.392156863, blue: 1.0, alpha: 1.0), name: "Down Pmt",   value: CGFloat(downPaymentSlider.value * priceSlider.value / 100))
        ]
    }
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSegment()
        
        let padding: CGFloat = 100
        let height = (view.frame.height - padding * 3) / 2.5
        
        pieChartView.frame = imageView.bounds
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
        
        //Constraints code:
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(pieChartView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: pieChartView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: pieChartView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: pieChartView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: pieChartView.bottomAnchor)
        ])
        
        //Constraints for the totalMonthlyLabel:
        totalMonthlyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalMonthlyLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            totalMonthlyLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            totalMonthlyLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
        //Constraints for the loanOutlet label:
        homePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homePriceLabel.topAnchor.constraint(equalTo: totalMonthlyLabel.bottomAnchor, constant: 8),
            homePriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: homePriceSign.trailingAnchor, constant: 8),
            homePriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        homePriceSign.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homePriceSign.widthAnchor.constraint(equalToConstant: 125),
            homePriceSign.topAnchor.constraint(equalTo: totalMonthlyLabel.bottomAnchor, constant: 8),
            homePriceSign.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            homePriceSign.trailingAnchor.constraint(equalTo: homePriceLabel.leadingAnchor, constant: -124),
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
            dpwnPaymentLabel.topAnchor.constraint(equalTo: priceSlider.bottomAnchor, constant: 30),
            dpwnPaymentLabel.leadingAnchor.constraint(greaterThanOrEqualTo: downPaymentPercentageLabel.trailingAnchor, constant: 8),
            dpwnPaymentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        downPaymentSign.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downPaymentSign.widthAnchor.constraint(equalToConstant: 125),
            downPaymentSign.topAnchor.constraint(equalTo: priceSlider.bottomAnchor, constant: 30),
            downPaymentSign.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            downPaymentSign.trailingAnchor.constraint(equalTo: downPaymentPercentageLabel.leadingAnchor, constant: -24)
        ])
        
        downPaymentPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downPaymentPercentageLabel.widthAnchor.constraint(equalToConstant: 76),
            downPaymentPercentageLabel.topAnchor.constraint(equalTo: priceSlider.bottomAnchor, constant: 30),
            downPaymentPercentageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            downPaymentPercentageLabel.trailingAnchor.constraint(equalTo: dpwnPaymentLabel.leadingAnchor, constant: -24)
        ])
        
        downPaymentSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downPaymentSlider.topAnchor.constraint(equalTo: dpwnPaymentLabel.bottomAnchor, constant: 12),
            downPaymentSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            downPaymentSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        interestPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            interestPercentageLabel.topAnchor.constraint(equalTo: downPaymentSlider.bottomAnchor, constant: 30),
            interestPercentageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            interestPercentageLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        interestPercentageSign.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            interestPercentageSign.widthAnchor.constraint(equalToConstant: 125),
            interestPercentageSign.topAnchor.constraint(equalTo: downPaymentSlider.bottomAnchor, constant: 30),
            interestPercentageSign.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            interestPercentageSign.trailingAnchor.constraint(equalTo: interestPercentageLabel.leadingAnchor, constant: -124)
        ])
        
        interestPercentageSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            interestPercentageSlider.topAnchor.constraint(equalTo: interestPercentageLabel.bottomAnchor, constant: 12),
            interestPercentageSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            interestPercentageSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        termSignLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            termSignLabel.widthAnchor.constraint(equalToConstant: 125),
            termSignLabel.topAnchor.constraint(equalTo: interestPercentageSlider.bottomAnchor, constant: 30),
            termSignLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            termSignLabel.trailingAnchor.constraint(equalTo: termAmountLabel.leadingAnchor, constant: -124)
        ])
        
        termAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            termAmountLabel.widthAnchor.constraint(equalToConstant: 125),
            termAmountLabel.topAnchor.constraint(equalTo: interestPercentageSlider.bottomAnchor, constant: 30),
            termAmountLabel.leadingAnchor.constraint(equalTo: termSignLabel.trailingAnchor, constant: 20),
            termAmountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        
        //    simplePieChartView.frame = CGRect(
        //      x: 0, y: height + padding * 2,
        //      width: view.frame.size.width, height: height
        //    )
        //
        //    simplePieChartView.segments = [
        //      Segment(color: .red,    value: 57),
        //      Segment(color: .blue,   value: 30),
        //      Segment(color: .green,  value: 25),
        //      Segment(color: .yellow, value: 40)
        //    ]
        //    view.addSubview(simplePieChartView)
        
    }
}
