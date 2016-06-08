//
//  ItemDetailsVC.swift
//  someJunk
//
//  Created by Kersuzan on 07/06/16.
//  Copyright © 2016 Kersuzan. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    
    var stores: [Store] = [Store]()
    var itemToEdit: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.storePicker.delegate = self
        self.storePicker.dataSource = self
        
        getStores()
        manageEditForm()
//        
//        let store1 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: appDelegate.managedObjectContext) as! Store
//        store1.name = "Casino"
//        
//        let store2 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: appDelegate.managedObjectContext) as! Store
//        store2.name = "Carrefour"
//        
//        let store3 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: appDelegate.managedObjectContext) as! Store
//        store3.name = "Auchan"
//        
//        let store4 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: appDelegate.managedObjectContext) as! Store
//        store4.name = "Wall Mart"
//        
//        let store5 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: appDelegate.managedObjectContext) as! Store
//        store5.name = "Amazon"
//        
//        let store6 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: appDelegate.managedObjectContext) as! Store
//        store6.name = "Jing Dong"
//        
//        appDelegate.saveContext()
    }
    
    func getStores() {
        let fetchRequest = NSFetchRequest(entityName: "Store")
        
        do {
            self.stores = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as! [Store]
            
            self.storePicker.reloadAllComponents()
        } catch {
            let error = error as NSError
            print(error.userInfo)
        }
    }
    
    func manageEditForm() {
        if let item = self.itemToEdit {
            if let title = item.title {
                self.titleField.text = title
            }
            
            if let details = item.details {
                self.detailsField.text = details
            }
            
            if let price = item.price {
                self.priceField.text = "\(price)"
            }
            
            if let store = item.store, let index = stores.indexOf(store) {
                self.storePicker.selectRow(index, inComponent: 0, animated: false)
            }
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        
        return store.name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    @IBAction func savePressed(sender: UIButton) {
        if validateForm() {
            var item: Item!
            
            if self.itemToEdit == nil {
                item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: appDelegate.managedObjectContext) as! Item
            } else {
                item = itemToEdit
            }
            
            item.title = titleField.text
            item.details = detailsField.text
            item.price = NSString(string: priceField.text!).doubleValue
            item.store = stores[self.storePicker.selectedRowInComponent(0)]
            
            // Save the context
            appDelegate.saveContext()
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            displayErrorMessage("The form is not valid.")
        }
    }
    
    func validateForm() -> Bool {
        guard self.titleField.text?.characters.count > 0 else {
            displayErrorMessage("Title Field cannot be blank.")
            
            return false
        }
        
        guard (self.priceField.text?.characters.count > 0) else {
            displayErrorMessage("Price Field cannot be blank.")
            
            return false
        }
        
        guard (Double(self.priceField.text!) != nil) else {
            
            displayErrorMessage("Price Field must be a numeric value.")
            
            return false
        }
        
        guard self.detailsField.text?.characters.count > 0 else {
            displayErrorMessage("Details Field cannot be blank.")
            
            return false
        }
        
        return true
    }
    
    func displayErrorMessage(message: String) {
        let alertController = UIAlertController(title: "SomeJunk", message: "Form Submission Error: \n \(message)", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
