//
//  LoginViewController.swift
//  Vortex Mortgage
//
//  Created by Alex Thompson on 6/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import AuthenticationServices

typealias AppleSignInBlock = ((_ userInfo:AppleInfoModel?,_ errorMessge:String?)->())?


class LoginViewController: UIViewController {
    
    var appleSignInBlock: AppleSignInBlock!

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
        
        appleButtonStackView.addArrangedSubview(appleButton)
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
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            switch authorization.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                let userIdentifier = appleIDCredential.user
                let firstName = appleIDCredential.fullName?.givenName ?? KeychainItem.firstName ?? ""
                let lastName = appleIDCredential.fullName?.familyName ?? KeychainItem.lastName ?? ""
                let email = appleIDCredential.email ?? KeychainItem.email ?? ""
                
                let fullName = firstName + " " + lastName
                
                KeychainItem.userid = userIdentifier
                KeychainItem.firstName = firstName
                KeychainItem.lastName = lastName
                KeychainItem.email = email
                
                let userInfo = AppleInfoModel(userid: userIdentifier, email: email, firstName: firstName, lastName: lastName, fullName: fullName)
                
                print(userInfo)
                
                // Save user in keychain
                self.saveUserInKeychain(userIdentifier)
                
                // dismiss the login view controller since im not landing on the profile vc anymore
                self.dismiss(animated: true, completion: nil)
                self.passDataToProfileViewController(userIdentifier: userIdentifier, firstName: firstName, lastName: lastName, email: email)
                
            case let passwordCredential as ASPasswordCredential:
                
                // Sign in using an existing iCloud Keychain credential.
                let username = passwordCredential.user
                let password = passwordCredential.password
                
                // For testing purposes create an alert to check everything
                DispatchQueue.main.async {
                    self.showAlert(username: username, password: password)
                }
            default:
                break
            }
        }
    
    private func passDataToProfileViewController(userIdentifier: String?, firstName: String?, lastName: String?, email: String?) {
        guard let viewController = self.presentingViewController as? HomeViewController else { return }

        DispatchQueue.main.async {


            viewController.firstName = firstName
            print(firstName!)

            viewController.lastName = lastName
            print(lastName!)
            if let email = email {
                viewController.email = email
                print(email)
                

            }
            
            self.present(viewController, animated: true)
        }
    }
    
    
    
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "VortexMortgage", account: "userIdentifier").saveItem(userIdentifier)
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
        print(error.localizedDescription)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension UIViewController {
    
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController") as?
            LoginViewController {
            loginViewController.modalPresentationStyle = .fullScreen
            loginViewController.isModalInPresentation = true
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
}
