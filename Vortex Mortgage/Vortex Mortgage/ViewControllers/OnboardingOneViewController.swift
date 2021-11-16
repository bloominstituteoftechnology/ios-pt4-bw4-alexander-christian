//
//  OnboardingOneViewController.swift
//  Vortex Mortgage
//
//  Created by Christian Lorenzo on 6/16/20.
//  Copyright © 2020 BloomTech. All rights reserved.
//

import UIKit

class OnboardingOneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func goToSecondVCButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToSecondVC", sender: self)
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
