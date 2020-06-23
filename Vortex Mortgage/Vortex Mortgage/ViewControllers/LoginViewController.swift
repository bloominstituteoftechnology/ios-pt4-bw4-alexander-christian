//
//  LoginViewController.swift
//  Vortex Mortgage
//
//  Created by Alex Thompson on 6/17/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import AuthenticationServices

typealias AppleSignInBlock = ((_ userInfo:AppleInfoModel?,_ errorMessge:String?)->())?


class LoginViewController: UIViewController {
    
    var appleSignInBlock: AppleSignInBlock!


    
    @IBOutlet var appleButtonStackView: ASAuthorizationAppleIDButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProviderLoginView()
        setUI()

    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
        
    }
    
    
    
    
        
        
    
    func setupProviderLoginView() -> ASAuthorizationAppleIDButton {
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.addTarget(self, action: #selector(handleAuthorization), for: .touchUpInside)

        return appleButton
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
                
               
                
                self.passDataToProfileViewController(userIdentifier: userIdentifier, fullName: firstName, email: email)
                
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
    
    private func passDataToProfileViewController(userIdentifier: String?, fullName: String?, email: String?) {
        guard let viewController = self.presentingViewController as? ProfileViewController else { return }
        
        DispatchQueue.main.async {
            
            if let id = userIdentifier {
                viewController.id.text = id
            }
            
            viewController.firstName.text = fullName
            
            
            
            if let email = email {
                viewController.emailLabel.text = email

            }
            self.dismiss(animated: true, completion: nil)
            
            
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
        if (error as NSError).code != 1001 {
            appleSignInBlock?(nil, error.localizedDescription)
        }
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

extension LoginViewController {
    func startAnimatingPressActions() {
        appleButtonStackView.addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        appleButtonStackView.addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    func setUI() {
        // set button Animation
        appleButtonStackView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        startAnimatingPressActions()
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 5.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.appleButtonStackView.transform = .identity
            },
                       completion: nil)
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
        }, completion: nil)
    }
}
