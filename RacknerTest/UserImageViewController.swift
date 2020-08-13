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
        
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imagePath = documents.appendingPathComponent("userImage.png")
        
        UserImage.image = UIImage(contentsOfFile: imagePath.path)!
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            UserImage.contentMode = .scaleAspectFit
            UserImage.image = pickedImage
            
            if let data = pickedImage.pngData() {
                
                let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let url = documents.appendingPathComponent("userImage.png")
                
                do {
                    try data.write(to: url)
                    
                } catch {
                    print("Unable to Write Data to Disk (\(error))")
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
