//
//  Item+CoreDataProperties.swift
//  someJunk
//
//  Created by Kersuzan on 05/05/16.
//  Copyright © 2016 Kersuzan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var title: String?
    @NSManaged var details: String?
    @NSManaged var price: NSNumber?
    @NSManaged var created_at: NSDate?
    @NSManaged var store: Store?
    @NSManaged var image: Image?
    @NSManaged var itemType: ItemType?

}
