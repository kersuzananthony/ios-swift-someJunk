//
//  AddStoreVC.swift
//  someJunk
//
//  Created by Kersuzan on 08/06/16.
//  Copyright © 2016 Kersuzan. All rights reserved.
//

import UIKit
import CoreData

class AddStoreVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addPictureButton: UIButton!
    @IBOutlet weak var storeImageView: UIImageView!
    @IBOutlet weak var storeNameTextField: UITextField!
    
    var imagePickerController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ItemDetailsVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if storeImageView.image != nil {
            self.addPictureButton.setImage(nil, forState: .Normal)
        }
    }
    
    // MARK: Dismiss Keyboard
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.storeNameTextField.resignFirstResponder()
        return true
    }


    @IBAction func addPicturePressed(sender: UIButton) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.addPictureButton.setImage(nil, forState: UIControlState.Normal)
        
        self.presentViewController(self.imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func addStorePressed(sender: UIButton) {
        if validateForm() {
            let store = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: appDelegate.managedObjectContext) as! Store
            
            store.name = self.storeNameTextField.text
            
            if let image = self.storeImageView.image {
                store.image?.setItemImage(image)
            }
            
            appDelegate.saveContext()
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func validateForm() -> Bool {
        guard self.storeNameTextField.text?.characters.count > 0 else {
            displayErrorMessage("Title cannot be blank.")
            
            return false
        }
        
        return true
    }
    
    func displayErrorMessage(message: String) {
        let alertController = UIAlertController(title: "SomeJunk", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.storeImageView.image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        UIImageWriteToSavedPhotosAlbum(image, nil, #selector(AddStoreVC.printImage), nil)
    }
    
    func printImage() {
        self.addPictureButton.setImage(nil, forState: .Normal)
        
        print("Image saved")
    }
}
