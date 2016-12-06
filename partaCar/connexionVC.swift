//
//  ViewController.swift
//  partaCar
//
//  Created by IncrediApps on 21/02/2016.
//  Copyright © 2016 IncrediApps. All rights reserved.
//

import UIKit

let infosUser:NSUserDefaults = NSUserDefaults.standardUserDefaults()

class connexionVC: UIViewController, AnimationPartaCarViewDelegate {
    
    // Variables du mainStoryBoard
    

    @IBOutlet weak var Utilisateur: UITextField!
    @IBOutlet weak var Password: UITextField!
    //@IBOutlet weak var animation: AnimationPartaCarView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var fond: UILabel!
    @IBOutlet weak var connect: UIButton!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var anim: AnimationPartaCarView!
    
   
    @IBAction func connexion(sender: AnyObject) {
        let ident:NSString = Utilisateur.text!
        let mdp:NSString = Password.text!
        activityIndicator.startAnimating()
        if Utilisateur.text == "" || Password.text == "" {
            displayAlert("Saisie incomplète", message: "Veuillez saisir tous les champs")   // Case vide = Alerte
        } else
        {
            let post:NSString = "identifiant=\(ident)&mdp=\(mdp)" // Remplace notre post
            
            NSLog("PostData: %@",post)
            
            let url:NSURL = NSURL(string: "http://incrediapps.com/login.php")! // URL de notre login.php percu comme un JSON
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)! //Encodage
            let postLength:NSString = String(postData.length)
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
                        activityIndicator.stopAnimating()
                        NSLog("Login OK");
                        
                        let idJSON:NSString = jsonData.valueForKey("id") as! NSString
                        let nomJSON:NSString = jsonData.valueForKey("nom") as! NSString
                        let prenomJSON:NSString = jsonData.valueForKey("prenom") as! NSString
                        let identifiantJSON:NSString = jsonData.valueForKey("identifiant") as! NSString
                        let telJSON:NSString = jsonData.valueForKey("tel") as! NSString!
                        let imageJSON:NSString = jsonData.valueForKey("imageProfil") as! NSString!
                        //print(" Le pseudo est :l\(idJSON)")
                        
                        infosUser.setObject(idJSON, forKey: "ID")
                        infosUser.setObject(nomJSON, forKey: "NOM")
                        infosUser.setObject(prenomJSON, forKey: "PRENOM")
                        infosUser.setObject(identifiantJSON, forKey: "IDENTIFIANT")
                        infosUser.setObject(telJSON, forKey: "TELEPHONE")
                        infosUser.setObject(imageJSON, forKey: "PROFIL")
                        //infosUser.setObject(1, forKey: "ESTCO")
                        infosUser.synchronize()
                        
                        self.performSegueWithIdentifier("goToProfil", sender: self)
                        
                    }else{
                        NSLog("Login échoué");
                        
                        displayAlert("Identifiant incorrect !", message: "L'identifiant ou le mot de passe ne correspondent pas ! ")
                       
                    }
                    
                } else {
                    NSLog("Ca va pas a la page")
                    displayAlert("Erreur !", message: "Connectez-vous à internet !")
                }
            } else {
                displayAlert("Erreur !", message: "Connectez-vous à internet !")
            }
            
        }//FIN CHAMPS VIDES
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // connect.enabled = false
       // let titleView = self.view as! AnimationPartaCarView
       // titleView.animationPartaCarViewDelegate = self
       // register.enabled = false
        fond.layer.cornerRadius = 10
        fond.clipsToBounds = true
      //   anim.addMouvementAnimation()
        
        
       // update()
    }

// must be internal or public.
    func update() {
        
    //animation.addMouvementAnimation()
    connect.hidden = true
    register.hidden = true
    var timer = NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        
        
        
}

    func subtractTime() {
        var seconds = 0
        
        while (seconds != 3) {
        seconds++
        }
        if seconds == 3 {
            
            connect.hidden = false
            register.hidden = false
            anim.hidden = true
            
        }
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /******** FONCTIONS POUR ADAPTER ET FAIRE DISPARAITRE LE CLAVIER ********/
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        Utilisateur.resignFirstResponder()
        Password.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Utilisateur.resignFirstResponder()
        Password.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    /******** FONCTION POUR AFFICHAGE D'ALERTE ********/
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func buttonInscriPressed(buttonInscri: UIButton){
    
    
    
    }
    func buttonCo2Pressed(buttonCo2: UIButton){
        let ident:NSString = Utilisateur.text!
        let mdp:NSString = Password.text!
        activityIndicator.startAnimating()
        if Utilisateur.text == "" || Password.text == "" {
            displayAlert("Saisie incomplète", message: "Veuillez saisir tous les champs")   // Case vide = Alerte
        } else
        {
            let post:NSString = "identifiant=\(ident)&mdp=\(mdp)" // Remplace notre post
            NSLog("PostData: %@",post)
            
            let url:NSURL = NSURL(string: "http://localhost:8888/partaCar/login.php")! // URL de notre login.php percu comme un JSON
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)! //Encodage
            let postLength:NSString = String(postData.length)
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
                        activityIndicator.stopAnimating()
                        NSLog("Login OK");
                        
                        let idJSON:NSString = jsonData.valueForKey("id") as! NSString
                        let nomJSON:NSString = jsonData.valueForKey("nom") as! NSString
                        let prenomJSON:NSString = jsonData.valueForKey("prenom") as! NSString
                        let identifiantJSON:NSString = jsonData.valueForKey("identifiant") as! NSString
                        let telJSON:NSString = jsonData.valueForKey("tel") as! NSString!
                        let imageJSON:NSString = jsonData.valueForKey("imageProfil") as! NSString!
                        
                        
                        infosUser.setObject(idJSON, forKey: "ID")
                        infosUser.setObject(nomJSON, forKey: "NOM")
                        infosUser.setObject(prenomJSON, forKey: "PRENOM")
                        infosUser.setObject(identifiantJSON, forKey: "IDENTIFIANT")
                        infosUser.setObject(telJSON, forKey: "TELEPHONE")
                        infosUser.setObject(imageJSON, forKey: "PROFIL")
                        //infosUser.setObject(1, forKey: "ESTCO")
                        infosUser.synchronize()
                        
                        self.performSegueWithIdentifier("goToProfil", sender: self)
                        
                    }else{
                        NSLog("Login échoué");
                        
                        displayAlert("Identifiant incorrect !", message: "L'identifiant ou le mot de passe ne correspondent pas ! ")
                    }
                    
                } else {
                    NSLog("Ca va pas a la page")
                    displayAlert("Erreur !", message: "Connectez-vous à internet !")
                }
            } else {
                displayAlert("Erreur !", message: "Connectez-vous à internet !")
            }
            
        }//FIN CHAMPS VIDES

    
    
    
    }

}

