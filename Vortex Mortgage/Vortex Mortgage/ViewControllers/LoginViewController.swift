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
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        
    }
    
    func performExistingAccountSetupFlows() {
        
        // prepare requests for both apple id and password
        
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with said requests
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            switch authorization.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                let userIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                let email = appleIDCredential.email
                print("Users name is \(fullName!), users email is \(email!).")
                
                // Save user in keychain
                self.saveUserInKeychain(userIdentifier)
                
            case let passwordCredential as ASPasswordCredential:
                
                // Sign in using an existing iCloud Keychain credential.
                let username = passwordCredential.user
                let password = passwordCredential.password
                print("Username: \(username), Password: \(password.removingPercentEncoding!)")
                
                // For testing purposes create an alert to check everything
                DispatchQueue.main.async {
                    self.showAlert(username: username, password: password)
                }
            default:
                break
            }
        }
    
    private func passDataToProfileViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        guard let viewController = self.presentingViewController as? ProfileViewController else { return }
        
        DispatchQueue.main.async {
            viewController.nameLabel.text = userIdentifier
            
            if let email = email {
                viewController.emailLabel.text = email
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.alexThompson.Vortex-Mortgage", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save user identifier to keychain")
        }
    }
    
    private func showAlert(username: String, password: String) {
        let message = "Vortex Mortgage has recieved you're credentials \n\n Username: \(username.capitalized)\n Password: \(password.removingPercentEncoding!)"
        let alertController = UIAlertController(title: "Keychain", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
        
}
