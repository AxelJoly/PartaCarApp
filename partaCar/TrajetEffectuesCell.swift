//
//  TrajetEffectuesCell.swift
//  partaCar
//
//  Created by Joly Axel on 05/04/2016.
//  Copyright © 2016 Wolfy. All rights reserved.
//

import UIKit

class TrajetEffectuesCell: UITableViewCell {
    
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