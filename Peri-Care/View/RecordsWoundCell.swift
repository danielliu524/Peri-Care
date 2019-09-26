//
//  RecordsWoundCell.swift
//  Peri-Care
//
//  Created by Daniel Liu on 15/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import CoreData

class RecordsWoundCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var recordsTableViewController: RecordsTableViewController!
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var titleView: UILabel!
    @IBOutlet var woundButton: UIButton!
    @IBAction func addPhotoButtonTapped(sender: UIButton) {
        let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {(action ) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                self.recordsTableViewController.present(imagePicker, animated: true, completion: nil)
            }
        })
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {(action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                self.recordsTableViewController.present(imagePicker, animated: true, completion: nil)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        photoSourceRequestController.addAction(cameraAction)
        photoSourceRequestController.addAction(photoLibraryAction)
        photoSourceRequestController.addAction(cancelAction)
        self.recordsTableViewController.present(photoSourceRequestController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Running")
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("run")
            woundButton.imageView!.clipsToBounds = true
            woundButton.setImage(selectedImage, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("run")
        woundButton.imageView?.contentMode = .scaleAspectFill
        woundButton.setImage(UIImage(named: "addPhoto"), for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
