//
//  HomeViewController.swift
//  Vortex Mortgage
//
//  Created by Alex Thompson on 6/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import AuthenticationServices

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.showLoginViewController()
        }
    }
}
