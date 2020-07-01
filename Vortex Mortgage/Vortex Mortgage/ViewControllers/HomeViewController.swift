//
//  HomeViewController.swift
//  Vortex Mortgage
//
//  Created by Alex Thompson on 6/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var firstName: String?
    var lastName: String?
    var email: String?
    
    // MARK: - Outlets
    
    @IBOutlet var settings: UIButton!
    @IBOutlet var loanCalculation: UIButton!
    @IBOutlet var profile: UIButton!
    @IBOutlet var logoContainerView: UIView!
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        DispatchQueue.main.async {
            self.showLoginViewController()
        }
    }
    
    func setupViews() {
        settings.layer.cornerRadius = 10
        settings.layer.shadowColor = UIColor.black.cgColor
        settings.layer.shadowOffset = .zero
        settings.layer.shadowRadius = 10
        settings.layer.shadowOpacity = 0.5
        loanCalculation.layer.cornerRadius = 10
        loanCalculation.layer.shadowColor = UIColor.black.cgColor
        loanCalculation.layer.shadowOffset = .zero
        loanCalculation.layer.shadowRadius = 10
        loanCalculation.layer.shadowOpacity = 0.5
        profile.layer.cornerRadius = 10
        profile.layer.shadowColor = UIColor.black.cgColor
        profile.layer.shadowOffset = .zero
        profile.layer.shadowRadius = 10
        profile.layer.shadowOpacity = 0.5
        logoContainerView.layer.cornerRadius = 38
    }
    
    // MARK: - Actions
    
    @IBAction func logoutPressed(_ UISender: Any) {
        DispatchQueue.main.async {
            self.showLoginViewController()
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileSegue" {
            guard let firstName = firstName, let lastName = lastName, let email = email else { return }
            guard let vc = segue.destination as? ProfileViewController else { return }
            vc.email = email
            vc.first = firstName
            vc.last = lastName
        }
    }
}
