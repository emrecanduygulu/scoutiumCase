//
//  ItemCell.swift
//  scoutiumProject
//
//  Created by emre can duygulu on 26.01.2021.
//  Copyright © 2021 emre can duygulu. All rights reserved.
//

import UIKit
import SDWebImage

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemTitle: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func present(url: String, title: String) {
        itemTitle.text = title
        itemTitle.textColor = .white
        
        let baseUrl = URL(string: "https://storage.googleapis.com/anvato-sample-dataset-nl-au-s1/life-1/\(url)")!
        
        itemImage.sd_setImage(with: baseUrl, placeholderImage: UIImage(named: "pngwing.com"))
        selectionStyle = .none
    }
}
