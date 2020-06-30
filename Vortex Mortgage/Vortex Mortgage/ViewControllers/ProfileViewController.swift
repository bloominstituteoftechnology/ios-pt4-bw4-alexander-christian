//
//  ProfileViewController.swift
//  Vortex Mortgage
//
//  Created by Alex Thompson on 6/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import CoreImage
import Photos

class ProfileViewController: UIViewController {
    
    
    //MARK: Properties
    var email: String?
    var first: String?
    var last: String?
    var phoneNumber: String?
    var location: String?
    
    //MARK: Outlets
    
    @IBOutlet var firstName: UILabel!
    @IBOutlet var lastName: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var profileView: UIView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var phoneImage: UIImageView!
    @IBOutlet var locationImage: UIImageView!
    @IBOutlet var cancelButton: UIButton!
    
    // MARK: Core Image Placeholder properties
    
    var originalImage: UIImage? {
        didSet {
//            guard let originalImage = originalImage else { return }
            
            var scaledSize = profileImage.bounds.size
            let scale: CGFloat = UIScreen.main.scale
            
            scaledSize =  CGSize(width: scaledSize.width * scale, height: scaledSize.height * scale)
        }
    }

    //MARK: View Controller life cycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        addUITweaks()
        
        originalImage = profileImage.image
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        self.emailLabel.text = email
        self.firstName.text = first
        self.lastName.text = last
    }
    
    func addUITweaks() {
        profileImage.layer.cornerRadius = 20
        profileView.layer.cornerRadius = 38
        saveButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        saveButton.layer.shadowColor = UIColor.black.cgColor
        saveButton.layer.shadowOffset = .zero
        saveButton.layer.shadowRadius = 10
        saveButton.layer.shadowOpacity = 0.5
        cancelButton.layer.shadowColor = UIColor.black.cgColor
        cancelButton.layer.shadowOffset = .zero
        cancelButton.layer.shadowRadius = 10
        cancelButton.layer.shadowOpacity = 0.5
    }
    
    private func presentImagePicketController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("The photo library isn't available.")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
    }
    //MARK: Actions
    
    @IBAction func editProfileTapped(_ sender: Any) {

        locationLabel.isHidden = true
        locationTextField.isHidden = false
        phoneNumberTextField.isHidden = false
        locationImage.isHidden = false
        phoneImage.isHidden = false
        saveButton.isHidden = false
        cancelButton.isHidden = false
        
        if phoneNumberTextField.isHidden == false {
            phoneNumberLabel.isHidden = true
        } else {
            phoneNumberLabel.isHidden = false
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        
        locationTextField.isHidden = true
        phoneNumberTextField.isHidden = true
        if phoneNumberTextField.text == "" {
            phoneImage.isHidden = true
        } else  {
            phoneImage.isHidden = false
            phoneNumberLabel.isHidden = false
        }
        if locationTextField.text == "" {
            locationImage.isHidden = true
        } else {
            locationImage.isHidden = false
            locationLabel.isHidden = false
        }
        saveButton.isHidden = true
        cancelButton.isHidden = true
        
        
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        phoneNumber = phoneNumberTextField.text
        location = locationTextField.text
        locationLabel.text = location
        phoneNumberLabel.text = phoneNumber
        phoneNumberTextField.isHidden = true
        locationTextField.isHidden = true
        cancelButton.isHidden = true
        saveButton.isHidden = true
        phoneNumberLabel.isHidden = false
        locationLabel.isHidden = false
        
        if phoneNumber == "" {
            phoneImage.isHidden = true
        } else {
            phoneImage.isHidden = false
        }
        
        if location == "" {
            locationImage.isHidden = true
        } else {
            locationImage.isHidden = false
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
