//
//  rechercheTrajetVC.swift
//  partaCar
//
//  Created by IncrediApps on 21/02/2016.
//  Copyright © 2016 IncrediApps. All rights reserved.
//
import UIKit

class rechercheTrajetVC: UITableViewController {
    
   let data = Data()
    // Variables du mainStoryBoard
   // @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ce qui permet de faire venir le menu
        if revealViewController() != nil {
            //Définit la largeur que prend le menu
            revealViewController().rearViewRevealWidth = 230
            
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
 
    override func viewWillAppear(animated: Bool) {
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.donnees.count
    }
    
override     
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:myCustomCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! myCustomCell
        let entre = data.donnees[indexPath.row]
        cell.conducteurLabel.text = entre.conducteur
        cell.departLabel.text = entre.depart
        cell.arriveLabel.text = entre.arrive
        cell.placeLabel.text = String(entre.placeDispo)
        cell.dateHoraireLabel.text = entre.dateHoraire
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "trajet"
        {
            let details = segue.destinationViewController as! CustomViewController
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell){
                let entre = data.donnees[indexPath.row]
                
                details.stringConducteur = entre.conducteur
                details.stringDepart = entre.depart
                details.stringArrive = entre.arrive
                details.stringPlace = String(entre.placeDispo)
                details.stringDateHoraire = entre.dateHoraire
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}