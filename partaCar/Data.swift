//
//  Data.swift
//  partaCar
//
//  Created by IncrediApps on 25/03/2016.
//  Copyright © 2016 IncrediApps. All rights reserved.
//

import Foundation


class Data {
    class Entree {
        let dateHoraire: String
        let depart: String
        let arrive: String
        let conducteur: String
        let placeDispo: Int
        
        init(dateHoraire: String, depart: String, arrive: String, conducteur: String, placeDispo: Int)
        {
            
            self.dateHoraire = dateHoraire
            self.depart = depart
            self.arrive = arrive
            self.conducteur = conducteur
            self.placeDispo = placeDispo
        }
    
    
}
    
    let donnees = [
        Entree(dateHoraire: "date", depart: "Sanary", arrive: "Bandol", conducteur: "Poppy", placeDispo: 3),
        Entree(dateHoraire: "", depart: "", arrive: "", conducteur: "", placeDispo: 0),
        Entree(dateHoraire: "", depart: "", arrive: "", conducteur: "", placeDispo: 0)]
    
}