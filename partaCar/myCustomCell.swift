//
//  myCustomCell.swift
//  partaCar
//
//  Created by IncrediApps on 25/03/2016.
//  Copyright © 2016 IncrediApps. All rights reserved.
//

import UIKit

class myCustomCell: UITableViewCell {
    
    @IBOutlet weak var conducteurLabel: UILabel!
    @IBOutlet weak var departLabel: UILabel!
    @IBOutlet weak var arriveLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var dateHoraireLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}