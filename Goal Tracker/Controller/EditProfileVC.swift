//
//  EditProfileVC.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/11/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var userNameTextField: customizeUITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editPhotoButton: customizeUIButton!
    @IBOutlet weak var editNameButton: customizeUIButton!
    @IBOutlet weak var doneButton: customizeUIButton!
    @IBOutlet weak var profileImageHeight: NSLayoutConstraint!
    @IBOutlet weak var cancelButton: customizeUIButton!
    
    let imagePicker = UIImagePickerController()
    var pickedImage: UIImage?
    
    //VIEW DID LOAD:
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        doneButton.isHidden = true
        cancelButton.isHidden = false
        userNameTextField.isHidden = true
        
        getDeviceModel()
     
    }
    
    //VIEW WILL APPEAR:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if pickedImage != nil {
            profileImageView.image = pickedImage
        } else {
            if let imageSaved = UserDefaults.standard.data(forKey: "userProfileImage") {
                profileImageView.image = UIImage(data: imageSaved)
            }
        }
        
    }
    
    //Gets the device Model and Update the top View Constraint based on Model.
    func getDeviceModel() {
        
        switch deviceType! {
            
        case "iphone 8 Plus":
            profileImageHeight.constant = 270
        case "iphone X":
            profileImageHeight.constant = 300
        default:
            print("nothing")
            return
        }
    }
    
    //EDIT PHOTO BUTTON PRESSED.
    @IBAction func editPhoto(_ sender: customizeUIButton) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    //EDIT NAME BUTTON PRESSED:
    @IBAction func editName(_ sender: customizeUIButton) {
        
        editPhotoButton.isHidden = true
        editNameButton.isHidden = true
        
        userNameTextField.isHidden = false
        doneButton.isHidden = false
        cancelButton.isHidden = true
        
    }
    
    //CANCEL BUTTON PRESSED:
    @IBAction func cancelButtonPressed(_ sender: customizeUIButton) {
        dismissViewController()
    }
    
    //DONE BUTTON PRESSED:
    @IBAction func doneButtonPressed(_ sender: customizeUIButton) {
        
        if pickedImage != nil {
            if let pickedImageData = UIImagePNGRepresentation(pickedImage!) {
                UserDefaults.standard.set(pickedImageData as Data , forKey: "userProfileImage")
            }
        }
        
        if userNameTextField.text != "" {
           UserDefaults.standard.set(userNameTextField.text! as String, forKey: "userName")
        }
                
        dismissViewController()
    }
}

//UIIMAGEPICKERCONTROLLER DELEGATE
extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imagePicked = info[UIImagePickerControllerEditedImage] as? UIImage else {return}
       // profileImageView.image = imagePicked
        pickedImage = imagePicked
        
        self.editNameButton.isHidden = true
        self.editPhotoButton.isHidden = true
        self.doneButton.isHidden = false
        self.cancelButton.isHidden = true
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
