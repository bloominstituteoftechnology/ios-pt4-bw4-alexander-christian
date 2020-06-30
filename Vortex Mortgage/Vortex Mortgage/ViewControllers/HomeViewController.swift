//
//  HomeViewController.swift
//  Vortex Mortgage
//
//  Created by Alex Thompson on 6/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var firstName: String?
    var lastName: String?
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
