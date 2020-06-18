//
//  OnboardingThreeViewController.swift
//  Vortex Mortgage
//
//  Created by Christian Lorenzo on 6/16/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class OnboardingThreeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func thirdVCButtonPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: "mainVC") as! LoginViewController
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: true, completion: nil)
    }
    
    
}
