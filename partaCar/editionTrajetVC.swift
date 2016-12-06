//
//  editionTrajetVC.swift
//  partaCar
//
//  Created by IncrediApps on 21/02/2016.
//  Copyright © 2016 IncrediApps. All rights reserved.
//

import UIKit


class editionTrajetVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    /** Variables du mainStoryBoard **/
    @IBOutlet weak var fondPicker1: UILabel!
    @IBOutlet weak var fondPicker2: UILabel!
    @IBOutlet weak var fondPicker3: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var monDatePicker: UIDatePicker!
    @IBOutlet weak var pickerNbPlaces: UIPickerView!
    @IBOutlet weak var pickerDestinations: UIPickerView!
    
    /** Variables persos **/
    
    var pickerDataPlaces = ["1", "2", "3", "4"] // Définition du tableau de données
    
    var pickerData = ["Bandol", "La Garde", "Ollioules", "La Seyne", "Sanary", "Six-Fours", "Toulon", "Hyères", "Pierrefeu", "Le Beausset", "Cuers", "Signes", "Carqueiranne", "La Valette", "Le Pradet", "La Crau", "Solliès-Pont", "Le-Revest", "La Londe", "Belgentier", "Fac"] // Définition du tableau de données
    
    var pickerDataDepart = ["Bandol", "La Garde", "Ollioules", "La Seyne", "Sanary", "Six-Fours", "Toulon", "Hyères", "Pierrefeu", "Le Beausset", "Cuers", "Signes", "Carqueiranne", "La Valette", "Le Pradet", "La Crau", "Solliès-Pont", "Le-Revest", "La Londe", "Belgentier", "Fac"] // Définition du tableau de données
    
    var user:NSString = ""
    var places = String()
    var destination = String!()
    var depart = String!()
    var horaires = NSDate()
    var horairesAlert:NSString = ""

    
    @IBAction func datePickerAction(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss" //:'ss.SSS'Z'"
        let strDate = monDatePicker.date
        //myDatePicker.dateFromString(date: strDate, format:  "yyyy-MM-dd HH:mm:ss")
        horaires =  strDate
        
        
        //dateFormatter.dateFormat = "dd'-'MM'-'yyyy' à 'HH':'mm"
        let strAlert = dateFormatter.stringFromDate(monDatePicker.date)
        horairesAlert = strAlert
    }
    
    
    
    @IBAction func confirmation(sender: AnyObject) {
        
        if (depart! == destination!) {
        
        }
        else {
            displayAlert("Confirmation", message: " De \(depart) à \(destination) le \(horairesAlert) pour \(places) personne(s)?")
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fondPicker1.layer.cornerRadius = 10
        fondPicker1.clipsToBounds = true
        
        fondPicker2.layer.cornerRadius = 10
        fondPicker2.clipsToBounds = true
        
        fondPicker3.layer.cornerRadius = 10
        fondPicker3.clipsToBounds = true
        
        // Ce qui permet de faire venir le menu
        if revealViewController() != nil {
            //Définit la largeur que prend le menu
            revealViewController().rearViewRevealWidth = 230
            
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        /** Ne pas oublier les delegate et DataSource **/
        self.pickerNbPlaces.dataSource = self;
        self.pickerNbPlaces.delegate = self;
        self.pickerDestinations.dataSource = self;
        self.pickerDestinations.delegate = self;
        
        
        let currentDate = NSDate()  //On récupère la date actuelle
        depart = pickerData[pickerDestinations.selectedRowInComponent(0)]
        destination = pickerData[pickerDestinations.selectedRowInComponent(0)]
        places = pickerDataPlaces[pickerNbPlaces.selectedRowInComponent(0)]
        let unMoisDePlus:NSTimeInterval = 31 * 24 * 60 * 60
        monDatePicker.maximumDate = currentDate.dateByAddingTimeInterval(unMoisDePlus)
        monDatePicker.minimumDate = currentDate
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**************** FONCTIONS POUR LES PICKERS VIEWS *****************/
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if (pickerView == pickerDestinations)
        {
            return 2
        } else
        {
            return 1
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == pickerNbPlaces){
            return pickerDataPlaces.count // Nombre d'élement de la liste (.count va compter le nombre d'éléments dans pickerData)
        }
        else
        {
            if component == 0 {
                return pickerDataDepart.count
            }
                
            else {
                return pickerData.count
            }
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == pickerNbPlaces){
            return pickerDataPlaces[row]  // On affiche la liste dans le picker view
        } else
        {
            if component == 0 {
                return pickerDataDepart[row]
            }
                
            else {
                return pickerData[row]
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == pickerNbPlaces){
            places = pickerDataPlaces[row]
        } else
        {
            if component == 0 {
                return depart = pickerDataDepart[row]
            }
                
            else {
                return destination = pickerData[row]
            }
            
        }
        
    }
    
    
    // Couleur du texte des pickerViews
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if (pickerView == pickerNbPlaces)
        {
        let textPlaces = pickerDataPlaces[row]
        let monTexte = NSAttributedString(string: textPlaces, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        return monTexte
            
        } else
        {
            let textDesti = pickerDataDepart[row]
            let monTexte = NSAttributedString(string: textDesti, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
            
            return monTexte
        }
    }
    
    /** FONCTION POUR L'ALERTE **/
    
    func displayAlert(title: String, message: String){
        
        
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction((UIAlertAction(title: "Modifier", style: .Default, handler: { (alert: UIAlertAction!) in print("")
            
            //self.navigationController?.popViewControllerAnimated(true)
            self.navigationController?.popToRootViewControllerAnimated(true)
        })))
        
        alert.addAction((UIAlertAction(title: "Valider", style: .Default, handler: { (alert: UIAlertAction!) in print("")
            
            self.user = infosUser.valueForKey("IDENTIFIANT") as! String
            let post:NSString = "user=\(self.user)&dateHeure=\(self.horairesAlert)&depart=\(self.depart)&arrivee=\(self.destination)&nbPlaces=\(self.places)" // Remplace notre post
            NSLog("PostData: %@",post)
            
            let url:NSURL = NSURL(string: "http://incrediapps.com/addTrajet.php")! // URL de notre login.php percu comme un JSON
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding,allowLossyConversion: true)! //Encodage
            
            let postLength:NSString = String(post.length)
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url) //Permet de faire des requetes
            request.HTTPMethod = "POST" // Type de méthode utilisé: ici c'est le POST et pas le GET.
            request.HTTPBody = postData // Le corps ==> Le notre chaine post encodée
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length") // Taille de la requete
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            let responseError: NSError?
            var response:NSURLResponse?
            
            var urlData: NSData?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            } catch _ as NSError {
                urlData = nil
            } catch {
                fatalError()
            }
            
            if ( urlData != nil ) {
                let res = response as! NSHTTPURLResponse!;
                
                NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    var jsonData:NSDictionary = NSDictionary()
                    do {
                        jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!,options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    }catch {  // handle error
                    }
                    
                    
                    let success:NSInteger = jsonData.valueForKey("erreur") as! NSInteger
                    
                    
                    NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                        NSLog("AJOUT OK");
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                        let dateJSON:NSString = jsonData.valueForKey("date") as! NSString
                        let departJSON:NSString = jsonData.valueForKey("depart") as! NSString
                        let arriveeJSON:NSString = jsonData.valueForKey("arrivee") as! NSString
                        let placesJSON:NSString = jsonData.valueForKey("nbPlaces") as! NSString
                    }else{
                        NSLog("Ajout échoué");
                    }
                    
                } else {
                    NSLog("Ca va pas a la page")
                    self.displayAlert("Erreur !", message: "Connectez-vous à internet !")
                }
            } else {
                self.displayAlert("Erreur !", message: "Connectez-vous à internet !")
            }
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}
