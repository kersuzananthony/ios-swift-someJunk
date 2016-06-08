//
//  Item.swift
//  someJunk
//
//  Created by Kersuzan on 05/05/16.
//  Copyright © 2016 Kersuzan. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Item: NSManagedObject {

    // Hook before insert
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created_at = NSDate() // Current date and time
    }
}
