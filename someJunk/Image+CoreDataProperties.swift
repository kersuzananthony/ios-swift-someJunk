//
//  Image+CoreDataProperties.swift
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

extension Image {

    @NSManaged var image: Image?
    @NSManaged var items: NSSet?
    @NSManaged var stores: NSSet?

}
