//
//  ListCell.swift
//  someJunk
//
//  Created by Kersuzan on 05/05/16.
//  Copyright © 2016 Kersuzan. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    func configureCell(item: Item) {
        self.titleLabel.text = item.title
        self.priceLabel.text = "$\(item.price!)"
        self.detailsLabel.text = item.details
    
        if let image = item.image?.getItemImg() {
            self.thumbImageView.image = image
        }
    }
}
