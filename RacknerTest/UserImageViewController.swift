//
//  UserImageViewController.swift
//  RacknerTest
//
//  Created by Christopher Horsfield on 8/12/20.
//  Copyright © 2020 Christopher Horsfield. All rights reserved.
//

import UIKit

class UserImageViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var UserImage: UIImageView!
    
    @IBAction func ShowImagePicker(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
            
        present(imagePicker, animated: true, completion: nil)
    }

   override func viewDidLoad() {
        super.viewDidLoad()
     
        imagePicker.delegate = self
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
     
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            UserImage.contentMode = .scaleAspectFit
            UserImage.image = pickedImage
        }
     
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
