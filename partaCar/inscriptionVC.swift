//
//  inscriptionVC.swift
//  partaCar
//
//  Created by IncrediApps on 21/02/2016.
//  Copyright © 2016 IncrediApps. All rights reserved.
//

import UIKit

class inscriptionVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Variable déclarée
    var signupActive = true
    var success = 1
    
    // Variables du mainStoryBoard
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var mdpTextField: UITextField!
    @IBOutlet weak var verifTextField: UITextField!
    @IBOutlet weak var imageProfil: UIImageView!
    @IBOutlet weak var fond: UILabel!
    
    /** Variables définies ici **/
    let imagePicker = UIImagePickerController()
    
    
    @IBAction func changementPhoto(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func ConfirmationInscription(sender:UIButton)
    {
        let prenom:NSString = prenomTextField.text!
        let nom:NSString = nomTextField.text!
        let pseudo:NSString = pseudoTextField.text!
        let tel:NSString = telTextField.text!
        let mdp:NSString = mdpTextField.text!
        let verif:NSString = verifTextField.text!
    
        if prenomTextField.text! == nomTextField.text! {
        
        displayAlert("Erreur", message: "Votre nom doit être différent de votre prénom")
        success=0
            
        } else if mdpTextField.text! != verifTextField.text! {
        
        displayAlert("Erreur", message: "Veuillez rentrer deux fois le même mot de passe")
        success=0
            
        } else if pseudoTextField.text! == nomTextField.text! || pseudoTextField.text! == prenomTextField.text! {
        
        displayAlert("Erreur", message: "Votre pseudo doit être différent de votre nom/prénom")
        success=0
            
        }
        
        
        if pseudoTextField.text! == "" || mdpTextField.text! == "" {
        displayAlert("Saisie incomplète", message: "Veuillez saisir tous les champs")   // Case vide = Alerte
        } else
        {
        if (success == 1)
        {
        do {
            
        let post:NSString = "identifiant=\(pseudo)&mdp=\(mdp)&nom=\(nom)&prenom=\(prenom)&tel=\(tel)" // Remplace notre post
        NSLog("PostData: %@",post)
        
        let url:NSURL = NSURL(string: "http://incrediapps.com/jsonsignup.php")!
        
        let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
        
        let postLength:NSString = String( postData.length )
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        var reponseError: NSError?
        var response: NSURLResponse?
        
        var urlData: NSData?
        do {
        urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
        } catch let error as NSError {
        reponseError = error
        urlData = nil
        }
        
        if ( urlData != nil ) {
        let res = response as! NSHTTPURLResponse!;
        
        NSLog("Response code: %ld", res.statusCode);
        
        if (res.statusCode >= 200 && res.statusCode < 300)
        {
        let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
        
        NSLog("Response ==> %@", responseData);
        
        //var error: NSError?
        
        let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
        
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        //[jsonData[@"success"] integerValue];
        
        NSLog("Success: %ld", success);
        
        if(success == 1)
        {
        NSLog("Sign Up SUCCESS");
        self.dismissViewControllerAnimated(true, completion: nil)
        alertConfirmation("Succès!", message: "Votre compte a bien été crée!")
        } else {
        var error_msg:NSString
        
        if jsonData["error_message"] as? NSString != nil {
        error_msg = jsonData["error_message"] as! NSString
        } else {
        error_msg = "Unknown Error"
        }
        displayAlert("Erreur", message: "Erreur")
        }
        } else {
        displayAlert("Sign Up Failed!", message: "Connection Failed")
        }
        }  else {
        displayAlert("Sign Up Failed!", message: "Connection Failure")
        }
        } catch {
        displayAlert("Sign Up Failed!", message: "Server Error")
        }
        }
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fond.layer.cornerRadius = 10
        fond.clipsToBounds = true
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        navigationController!.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.blueColor()
    }
    
    
    /******** FONCTIONS POUR ADAPTER ET FAIRE DISPARAITRE LE CLAVIER ********/
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        prenomTextField.resignFirstResponder()
        nomTextField.resignFirstResponder()
        pseudoTextField.resignFirstResponder()
        telTextField.resignFirstResponder()
        mdpTextField.resignFirstResponder()
        verifTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        prenomTextField.resignFirstResponder()
        nomTextField.resignFirstResponder()
        pseudoTextField.resignFirstResponder()
        telTextField.resignFirstResponder()
        mdpTextField.resignFirstResponder()
        verifTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    /******** FONCTION POUR AFFICHAGE D'ALERTES ********/
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func alertConfirmation(title: String, message: String){
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (alert: UIAlertAction!) in print("")
            self.navigationController?.popToRootViewControllerAnimated(true)
            //Fonction qui permet d'afficher une alerte lorsque un champ est incomplet // mot de passe/ID incorrecte)
            self.dismissViewControllerAnimated(true, completion: nil)

        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /******** FONCTION PERMETTANT LE CHOOSER PICTURE *********/
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageProfil.contentMode = .ScaleAspectFit
        imageProfil.image = image
        imageProfil.layer.cornerRadius = imageProfil.frame.width/2
        imageProfil.clipsToBounds = true
        dismissViewControllerAnimated(true, completion: nil)
}
}