//
//  OnboardingThreeViewController.swift
//  Vortex Mortgage
//
//  Created by Christian Lorenzo on 6/16/20.
//  Copyright © 2020 BloomTech. All rights reserved.
//

import UIKit

class OnboardingThreeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func thirdVCButtonPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: true, completion: nil)
    }
    
    
}
