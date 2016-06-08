//
//  Image.swift
//  someJunk
//
//  Created by Kersuzan on 05/05/16.
//  Copyright © 2016 Kersuzan. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Image: NSManagedObject {

    func setItemImage(img: UIImage) {
        self.image = img
    }
    
    func getItemImg() -> UIImage? {
        if let img = self.image as? UIImage {
            return img
        }
        
        return nil
    }

}
