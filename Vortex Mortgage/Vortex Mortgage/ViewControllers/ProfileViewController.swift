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
    var shouldBeDisplayed: Bool?
    var savedPhoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")
    var savedLocation = UserDefaults.standard.string(forKey: "location")

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
            var scaledSize = profileImage.bounds.size
            let scale: CGFloat = UIScreen.main.scale
            scaledSize =  CGSize(width: scaledSize.width * scale, height: scaledSize.height * scale)
        }
    }
    
    //MARK: View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ifShouldBeDisplayed()
        phoneNumberTextField.text = savedPhoneNumber
        updateViews()
        addUITweaks()
        originalImage = profileImage.image
        shouldBeDisplayed = false
        locationTextField.text = savedLocation
       
        
        if locationTextField.text == ""  {
        locationImage.isHidden = true
        locationLabel.isHidden = true
        } else {
            locationImage.isHidden = false
            locationLabel.isHidden = false
            locationLabel.text = locationTextField.text
        }
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        self.emailLabel.text = email
        self.firstName.text = first
        self.lastName.text = last
        
        if phoneNumberTextField.text == ""  {
        phoneImage.isHidden = true
        phoneNumberLabel.isHidden = true
        } else {
            phoneImage.isHidden = false
            phoneNumberLabel.isHidden = false
            phoneNumberLabel.text = phoneNumberTextField.text
        }
    }
    
    func ifShouldBeDisplayed() {
        if shouldBeDisplayed == false {
            phoneImage.isHidden = false
            locationImage.isHidden = false
        } else {
            phoneImage.isHidden = true
            locationImage.isHidden = true
        }
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
    
    private func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("The photo library isn't available.")
            return
        }
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
        UserDefaults.standard.set(location, forKey: "location")
        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
        phoneNumberLabel.text = UserDefaults.standard.string(forKey: "phoneNumber")
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
    
    @IBAction func choosePhotoPressed(_ sender: Any) {
        presentImagePickerController()
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func savePhotoPressed(_ sender: Any) {
        guard let originalImage = originalImage else { return }
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else { return }
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: originalImage)
            }) { success, error in
                if let error = error {
                    print("An error occured: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.presentSuccessfulAlert()
                }
            }
        }
    }
    
    private func presentSuccessfulAlert() {
        let alert = UIAlertController(title: "Success!", message: "Photo Saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: Extentions

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let picture = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        profileImage.image = picture
        let data = picture.pngData()
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("image")
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
