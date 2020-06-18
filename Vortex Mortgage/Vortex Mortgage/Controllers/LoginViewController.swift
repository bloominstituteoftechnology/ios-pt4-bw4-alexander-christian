//
//  LoginViewController.swift
//  Vortex Mortgage
//
//  Created by Alex Thompson on 6/17/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import AuthenticationServices



class LoginViewController: UIViewController {
    
    @IBOutlet var appleButtonStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProviderLoginView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
    }
    
    func setupProviderLoginView() {
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.addTarget(self, action: #selector(handleAuthorization), for: .touchUpInside)
        self.appleButtonStackView.addArrangedSubview(appleButton)
    }
    
    @objc func handleAuthorization() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
//        controller.delegate = self
//        controller.presentationContextProvider = self
        controller.performRequests()
        
    }
    
    func performExistingAccountSetupFlows() {
        
        // prepare requests for both apple id and password
        
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with said requests
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
//        authorizationController.delegate = self
        authorizationController.performRequests()
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
