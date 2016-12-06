//
//  mesFonctions.swift
//  partaCar
//
//  Created by IncrediApps on 25/03/2016.
//  Copyright © 2016 IncrediApps. All rights reserved.
//

import Foundation

class mesFonctions: NSObject {
    
    func connexion(identifiant: NSString, motdepasse: NSString, urlSite: NSURL) -> Int {
        let ident:NSString = identifiant
        let mdp:NSString = motdepasse
        var errorCode: Int = 0
        
        if ident == "" || mdp == "" {
            errorCode = 4   // Case vide = Alerte
        } else
        {
            let post:NSString = "identifiant=\(ident)&mdp=\(mdp)" // Remplace notre post
            
            NSLog("PostData: %@",post)
            
            let url:NSURL = urlSite// URL de notre login.php percu comme un JSON
            
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
                        NSLog("Login OK");
                        
                     /*   let idJSON:NSString = jsonData.valueForKey("id") as! NSString
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
                        
                        performSegueWithIdentifier("goToProfil", sender: self) */
                        
                    }else{
                        NSLog("Login échoué");
                        
                        errorCode = success
                        
                        return errorCode
                    }
                    
                } else {
                    NSLog("Ca va pas a la page")
                  
                    errorCode = 2
                    
                    return errorCode

                }
            } else {
                //displayAlert("Erreur !", message: "Connectez-vous à internet !")
            
                errorCode = 3
                
                return errorCode
            }
            
        }//FIN CHAMPS VIDES
        return 5
    }
}