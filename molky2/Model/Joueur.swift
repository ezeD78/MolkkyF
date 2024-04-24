//
//  Joueur.swift
//  molky2
//
//  Created by Ezequiel Gomes on 29/01/2024.
//

import Foundation



class Joueur: Hashable {
    
    var nom : String
    var score = 0
    var nbZeroconssecutif = 0
    var eliminate = false
    var winner = false 
    init(nom: String) {
        self.nom = nom
    }
    
    static func == (lhs: Joueur, rhs: Joueur) -> Bool {
        return lhs.nom == rhs.nom
    }
 


    
    func hash(into hasher: inout Hasher) {
        hasher.combine(nom)
    }
    
    
    func reset ()  {
        score = 0
        nbZeroconssecutif = 0
        eliminate = false
         winner = false
        
        
    }
    
    

    
}
