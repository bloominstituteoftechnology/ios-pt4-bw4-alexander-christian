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
    
    //MARK: - Properties
    var email: String?
    var first: String?
    var last: String?
    var phoneNumber: String?
    var location: String?
    var shouldBeDisplayed: Bool?
    var savedPhoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")
    var savedLocation = UserDefaults.standard.string(forKey: "location")
    
    enum StorageType {
        case userDefaults
        case fileSystem
    }

    //MARK: - Outlets
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
    
    // MARK: - Core Image Placeholder properties
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
        phoneNumberTextField.text = savedPhoneNumber
        locationTextField.text = savedLocation
        updateLocationLabel()
        updatePhoneNumberLabel()
        updateViews()
        addUITweaks()
        originalImage = profileImage.image
        shouldBeDisplayed = false
        dismissKeyboardFunc()
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        self.emailLabel.text = email
        self.firstName.text = first
        self.lastName.text = last
    }
    
    func updateLocationLabel() {
        if locationTextField.text == ""  {
            locationImage.isHidden = true
            locationLabel.isHidden = true
        } else {
            locationImage.isHidden = false
            locationLabel.isHidden = false
            locationLabel.text = locationTextField.text
        }
    }
    
    func updatePhoneNumberLabel() {
        if phoneNumberTextField.text == ""  {
            phoneImage.isHidden = true
            phoneNumberLabel.isHidden = true
        } else {
            phoneImage.isHidden = false
            phoneNumberLabel.isHidden = false
            phoneNumberLabel.text = phoneNumberTextField.text
        }
    }
    
    func dismissKeyboardFunc() {
        let tap:  UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
    
    private func store(image: UIImage, forKey key: String, withStorageType storageType: StorageType) {
        if let pngRepresentation = image.pngData() {
            switch storageType {
            case .fileSystem:
                if let filePath = filePath(forKey: key) {
                    do {
                        try pngRepresentation.write(to: filePath, options: .atomic)
                    } catch let error {
                        print("Saving file resulted in error: ", error)
                    }
                }
            case .userDefaults:
                UserDefaults.standard.set(pngRepresentation, forKey: key)
            }
        }
    }
    
    private func retrieveImage(forKey key: String, inStorageType storageType: StorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            if let filePath = self.filePath(forKey: key),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                
                return image
            }
        }
        
        return nil
    }
    
    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    //MARK: - Actions
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
    
    @IBAction func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
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

// MARK: - Extentions

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let picture = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        profileImage.image = picture
        if let data = picture.pngData() {
            let fileManager = FileManager.default
            let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documents.appendingPathComponent("avatar")
            
//            do {
//                try data.write(to: url)
//
//                UserDefaults.standard.set(url, forKey: "picture")
//            } catch {
//                print("unable to write data to disk (\(error))")
//            }
        }
        
//        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("image")
//        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
