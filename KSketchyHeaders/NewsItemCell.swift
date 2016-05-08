//
//  NewsItemCell.swift
//  KSketchyHeaders
//
//  Created by Khant Zaw Ko on 9/5/16.
//  Copyright © 2016 Khant Zaw Ko. All rights reserved.
//

import UIKit

class NewsItemCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var newsItem: NewsItem? {
        
        didSet {
            
            if let item = newsItem {
                categoryLabel.text = item.category.toString()
                categoryLabel.textColor = item.category.toColor()
                summaryLabel.text = item.summary
                
            } else {
                
                categoryLabel.text = nil
                summaryLabel.text = nil
                
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
