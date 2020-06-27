//
//  ProfileViewController.swift
//  Vortex Mortgage
//
//  Created by Alex Thompson on 6/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import AuthenticationServices

class ProfileViewController: UIViewController {
    
    
    //MARK: Properties
    var email: String?
    var first: String?
    var last: String?
    
    //MARK: Outlets
    
    @IBOutlet var firstName: UILabel!
    @IBOutlet var lastName: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var id: UILabel!
    @IBOutlet var profileView: UIView!
    @IBOutlet var profileImage: UIView!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var locationTextField: UITextField!
    
    
    //MARK: View Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.text = first
        lastName.text = last
        emailLabel.text = email
        emailLabel.layer.borderWidth = 0.5
        emailLabel.layer.borderColor = UIColor.black.cgColor
        emailLabel.layer.cornerRadius = 5
        profileImage.layer.cornerRadius = 20
        profileView.layer.cornerRadius = 38
        
    }
    
    //MARK: Actions
    
    @IBAction func editProfileTapped(_ sender: Any) {
        
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
