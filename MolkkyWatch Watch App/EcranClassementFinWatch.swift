//
//  EcranClassementFinWatch.swift
//  MolkkyWatch Watch App
//
//  Created by Ezequiel Gomes on 11/03/2024.
//

import SwiftUI

struct EcranClassementFinWatch: View {
   
    var findujeux : Bool
    var joueurs : [Joueur]
    var couleurs = [Color(cgColor: CGColor(red: 0.93, green: 0.69, blue: 0.35, alpha: 1)),Color(cgColor: CGColor(red: 0.82, green: 0.28, blue: 0.28, alpha: 0.8)),Color(cgColor: CGColor(red: 0.93, green: 0.93, blue: 0.92, alpha: 1))]
    
    var body: some View {
        
        ScrollView {
            ForEach(joueurs,id:\.self) { joueur in
                HStack {
                    
                    
                    if joueur.winner{
                        Text(joueur.nom).foregroundStyle(couleurs[0]).bold()
                        Spacer()
                        Image(systemName: "crown").foregroundColor(couleurs[0]).bold()
                        Text("\(joueur.score)").foregroundStyle(couleurs[0]).bold()
                    }
                    else if joueur.eliminate {
                        Text(joueur.nom).foregroundStyle(couleurs[1])
                        Spacer()
                        Image(systemName: "xmark").foregroundColor(couleurs[1]).bold()
                        Text("\(joueur.score)").foregroundStyle(couleurs[1])
                    }
                    
                    else {
                        Text(joueur.nom)
                        Spacer()
                        Text("\(joueur.score)")
                    }
                    
                }.padding()
                
            }
            
            
            
            if findujeux {
                NavigationLink(destination: {
                    EcranJeuxWatch(gameBrain: GameBrain(joueurs: joueurs))
                }, label: {
                    Text("Revanche")
                }).padding()
            }
            
            
        }
        
        Spacer()
            .navigationTitle("Scores : ")
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EcranClassementFinWatch(findujeux: true, joueurs: GameBrain(nomJoueurs: ["Franck","David","Marc","Jacques"], isOne: true).test())
}
