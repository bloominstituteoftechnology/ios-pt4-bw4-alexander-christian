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
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var firstName: UILabel!
    @IBOutlet var id: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.showLoginViewController()
        }
    }
    
    @IBAction func signOutPressed() {
        KeychainItem.deleteUserIdentifierFromKeychain()
        firstName.text = ""
        emailLabel.text = ""
        
        DispatchQueue.main.async {
            self.showLoginViewController()
        }
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
