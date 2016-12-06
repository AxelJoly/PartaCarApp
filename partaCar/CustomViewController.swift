//
//  CustomViewController.swift
//  partaCar
//
//  Created by IncrediApps on 25/03/2016.
//  Copyright © 2016 IncrediApps. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    
    @IBOutlet weak var conducteurLabel: UILabel!
    @IBOutlet weak var departLabel: UILabel!
    @IBOutlet weak var arriveLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var dateHoraireLabel: UILabel!
    @IBOutlet weak var passager1Label: UILabel!
    @IBOutlet weak var passager2Label: UILabel!
    @IBOutlet weak var passager3Label: UILabel!
    @IBOutlet weak var passager4Label: UILabel!
    
    
    var stringConducteur: String = ""
    var stringArrive: String = ""
    var stringDepart: String = ""
    var stringDateHoraire: String = ""
    var stringPlace: String = ""
    var stringPassager1: String = ""
    var stringPassager2: String = ""
    var stringPassager3: String = ""
    var stringPassager4: String = ""
    var stringId: String = ""
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        majLabel()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func majLabel(){
        
        conducteurLabel.text = stringConducteur
        departLabel.text = stringDepart
        arriveLabel.text = stringArrive
        placeLabel.text = stringPlace
        dateHoraireLabel.text = stringDateHoraire
        
        if(stringPassager1 != "")
        {
        passager1Label.text = stringPassager1
        }else{
            passager1Label.hidden = true
        }
        
        if(stringPassager2 != "")
        {
            passager2Label.text = stringPassager2
        }else{
            passager2Label.hidden = true
        }

        if(stringPassager3 != "")
        {
            passager3Label.text = stringPassager3
        }else{
            passager3Label.hidden = true
        }

        if(stringPassager4 != "")
        {
            passager4Label.text = stringPassager4
        }else{
            passager4Label.hidden = true
        }

        
    }
    
    func displayAlert(title: String, message: String){
        
        
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction((UIAlertAction(title: "Modifier", style: .Default, handler: { (alert: UIAlertAction!) in print("")
            
            //self.navigationController?.popViewControllerAnimated(true)
            self.navigationController?.popToRootViewControllerAnimated(true)
        })))
        
        alert.addAction((UIAlertAction(title: "Valider", style: .Default, handler: { (alert: UIAlertAction!) in print("")
            
            //self.user = infosUser.valueForKey("IDENTIFIANT") as! String
            let post:NSString = "user=\(infosUser.valueForKey("IDENTIFIANT") as! String)&id=\(self.stringId)&passager1=\(self.stringPassager1)&passager2=\(self.stringPassager2)&passager3=\(self.stringPassager3)&passager4=\(self.stringPassager4)&place=\(self.stringPlace)" // Remplace notre post
            NSLog("PostData: %@",post)
            
            let url:NSURL = NSURL(string: "http://incrediapps.com/addPassager.php")! // URL de notre login.php percu comme un JSON
            
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
                        
                        let userJSON:NSString = jsonData.valueForKey("user") as! NSString
                        let idJSON:NSString = jsonData.valueForKey("id") as! NSString
                        let placeJSON:NSString = jsonData.valueForKey("place") as! NSString
                        
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

    func displayAlertComplet(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    @IBAction func Participer(sender: AnyObject) {
       let place = Int(placeLabel.text!)
        if( place != 0)
        {
               displayAlert("Confirmation", message: "Voulez vous confirmer votre présence le \(dateHoraireLabel.text!) avec \(conducteurLabel.text!)?")
            
            
        }else
        {
            displayAlertComplet("Oups!", message: "\(conducteurLabel.text!) n'a plus de place dans sa voiture ")
        }
    }
}