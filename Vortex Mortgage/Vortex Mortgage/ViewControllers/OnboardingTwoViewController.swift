//
//  OnboardingTwoViewController.swift
//  Vortex Mortgage
//
//  Created by Christian Lorenzo on 6/16/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class OnboardingTwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func goToThirdVCButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToThirdVC", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // df sdfsdfsdfsdfa stsdfsspsrsdf(dfesse:sdfStdfosdarddfsdfsdsSegue, sender: Any?) {
        // sdfsdfGet sdfsdfthe nesf visdfsdfesdfw csdfsdfntroldfsddfsdfsdffer usdsdestidffsation.
        // Pass the selected object to the new view controller.dsfsdfs
    }
    */

}
