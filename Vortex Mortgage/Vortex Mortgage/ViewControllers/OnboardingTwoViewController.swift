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

<<<<<<< Updated upstream:Vortex Mortgage/Vortex Mortgage/Controllers/OnboardingTwoViewController.swift
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
||||||| merged common ancestors:Vortex Mortgage/Vortex Mortgage/ViewControllers/OnboardingTwoViewController.swift
    // df sdfsdfsdfsdfa stsdfsspsrsdf(dfesse:sdfStdfosdarddfsdfsdsSegue, sender: Any?) {
        // sdfsdfGet sdfsdfthe nesf visdfsdfesdfw csdfsdfntroldfsddfsdfsdffer usdsdestidffsation.
        // Pass the selected object to the new view controller.dsfsdfs
=======
    // In a storyboard-basedsdfsdf application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
>>>>>>> Stashed changes:Vortex Mortgage/Vortex Mortgage/ViewControllers/OnboardingTwoViewController.swift
    }
    */

}
