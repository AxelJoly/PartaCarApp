//
//  menuVC.swift
//  partaCar
//
//  Created by IncrediApps on 21/02/2016.
//  Copyright © 2016 IncrediApps. All rights reserved.//

import UIKit


class menuVC: UITableViewController {
    
    // Variables du mainStoryBoard
    @IBOutlet weak var labelBienvenue: UILabel!
    @IBOutlet weak var imageUtilisateur: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func viewWillAppear(animated: Bool) {
        labelBienvenue.text="Bienvenue " + (infosUser.valueForKey("IDENTIFIANT") as! String) + "🙄"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}