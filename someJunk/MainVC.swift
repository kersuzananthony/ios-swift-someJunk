//
//  ViewController.swift
//  someJunk
//
//  Created by Kersuzan on 05/05/16.
//  Copyright © 2016 Kersuzan. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    var fetchResultController: NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        attemptFetch()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = fetchResultController.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = self.fetchResultController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        if let record = self.fetchResultController.objectAtIndexPath(indexPath) as? Item {
            cell.configureCell(record)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 132.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let objects = self.fetchResultController.fetchedObjects where objects.count > 0 {
            let item = objects[indexPath.row] as! Item
            
            performSegueWithIdentifier("ItemDetailsVC", sender: item)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ItemDetailsVC" {
            if let destinationVC = segue.destinationViewController as? ItemDetailsVC, let item = sender as? Item {
                destinationVC.itemToEdit = item
            }
        }
    }
}

extension MainVC: NSFetchedResultsControllerDelegate {
    
    func attemptFetch() {
        setFetchedResults()
        
        do {
            try self.fetchResultController.performFetch()
        } catch {
            let error = error as NSError
            print("\(error), \(error.userInfo)")
        }
    }
    
    func setFetchedResults() {
        let section: String? = self.segment.selectedSegmentIndex == 1 ? "store.name" : nil
        
        let fetchRequest = NSFetchRequest(entityName: "Item")
        let sortDescriptor = NSSortDescriptor(key: "created_at", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.managedObjectContext, sectionNameKeyPath: section, cacheName: nil)
        
        controller.delegate = self
        
        self.fetchResultController = controller
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case NSFetchedResultsChangeType.Insert:
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            break
            
        case NSFetchedResultsChangeType.Delete:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            break
        
        case .Update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! ItemCell
                configureCell(cell, indexPath: indexPath)
            }
            break
            
        case .Move:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
            break
        } // End swith statement
    }
    
    func generateTestData() {
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: appDelegate.managedObjectContext) as! Item
        item.title = "Title of my object"
        item.details = "I dont know if this object is cool or not"
        item.price = 100.0
        
        let item2 = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: appDelegate.managedObjectContext) as! Item
        item2.title = "Title of my second object"
        item2.details = "I dont know if this second object is cool or not"
        item2.price = 200.0

        
        let item3 = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: appDelegate.managedObjectContext) as! Item
        item3.title = "Title of my third object"
        item3.details = "I dont know if this third object is cool or not"
        item3.price = 300.0

        appDelegate.saveContext()
    }
}

