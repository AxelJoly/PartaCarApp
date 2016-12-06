//
//  monProfilVC.swift
//  partaCar
//
//  Created by IncrediApps on 21/02/2016.
//  Copyright © 2016 IncrediApps. All rights reserved.
//

import UIKit


class monProfilVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    /** Variables de mon mainStoryBoard **/
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var fondSegmented: UILabel!
    @IBOutlet weak var maPhotoDeProfil: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    /** Variables définies ici **/
    let imagePicker = UIImagePickerController()
    var donnees = [Entree]()
    
    @IBAction func changementDePhoto(sender: AnyObject) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        get_data_from_url("http://incrediapps.com/trajetsEffectues.php")
        // Ce qui permet de faire venir le menu
        if revealViewController() != nil {
            //Définit la largeur que prend le menu
            revealViewController().rearViewRevealWidth = 230
            
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        fondSegmented.layer.cornerRadius = 40
        imagePicker.delegate = self

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return donnees.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:TrajetEffectuesCell = tableView.dequeueReusableCellWithIdentifier("CellTrajetsEffectues", forIndexPath: indexPath) as! TrajetEffectuesCell
        let entre: Entree
        
        
        entre = donnees[indexPath.row]
        
        
        cell.conducteurLabel.text = entre.conducteur
        cell.departLabel.text = entre.depart
        cell.arriveLabel.text = entre.arrive
        cell.placeLabel.text = String(entre.placeDispo)
        cell.dateHoraireLabel.text = entre.dateHoraire
        return cell
    }

    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /******** FONCTION PERMETTANT LE CHOOSER PICTURE *********/
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
            maPhotoDeProfil.contentMode = .ScaleAspectFit
            maPhotoDeProfil.image = image
            maPhotoDeProfil.layer.cornerRadius = maPhotoDeProfil.frame.width/2
            maPhotoDeProfil.clipsToBounds = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func indexChanged(sender: AnyObject) {
    
    switch segmentedControl.selectedSegmentIndex
    {
    case 0:
        
       get_data_from_url("http://incrediapps.com/trajetbdd.php")
        do_table_refresh()
 
   
    case 1:
    
        get_data_from_url("http://incrediapps.com/trajetbdd.php")
        do_table_refresh()
        
    default:
    break;
    }
    }
    
    func get_data_from_url(url:String)
    {
        let httpMethod = "GET"
        let timeout = 15
        let url = NSURL(string: url)
        let urlRequest = NSMutableURLRequest(URL: url!,
                                             cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData,
                                             timeoutInterval: 15.0)
        let queue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(
            urlRequest,
            queue: queue,
            completionHandler: {(response: NSURLResponse?,
                data: NSData?,
                error: NSError?) in
                if data!.length > 0 && error == nil{
                    let json = NSString(data: data!, encoding: NSASCIIStringEncoding)
                    self.extract_json(json!)
                }else if data!.length == 0 && error == nil{
                    print("Nothing was downloaded")
                } else if error != nil{
                    print("Error happened = \(error)")
                }
            }
        )
    }
    
    func extract_json(data:NSString)
    {
        var parseError: NSError?
        let jsonData:NSData = data.dataUsingEncoding(NSASCIIStringEncoding)!
        let json: AnyObject?
        do {
            json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
        } catch let error as NSError {
            parseError = error
            json = nil
        }
        if (parseError == nil)
        {
            if let liste = json as? NSArray
            {
                for (var i = 0; i < liste.count ; i++ )
                {
                    if let obj = liste[i] as? NSDictionary
                    {
                        let _conducteur = obj["conducteur"] as? String
                        let _depart = obj["depart"] as? String
                        let _arrive = obj["arrive"] as? String
                        let _place = obj["placeDispo"] as? String
                        let _dateHoraire = obj["dateHoraire"] as? String
                        let _id = obj["id"] as? String
                        let _passager1 = obj["passager1"] as? String
                        let _passager2 = obj["passager2"] as? String
                        let _passager3 = obj["passager3"] as? String
                        let _passager4 = obj["passager4"] as? String
                        
                        self.donnees += [Entree(dateHoraire: _dateHoraire!, depart: _depart!, arrive: _arrive!, conducteur: _conducteur!, placeDispo: _place!, id: _id!, passager1: _passager1!, passager2: _passager2!, passager3: _passager3!, passager4: _passager4!)]
                        
                        
                    }
                }
            }
        }
        do_table_refresh();
    }
    
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
    
  
}