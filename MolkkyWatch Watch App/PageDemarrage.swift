//
//  ContentView.swift
//  MolkkyWatch Watch App
//
//  Created by Ezequiel Gomes on 18/02/2024.
//

import SwiftUI

struct PageDemarrage: View {
    @StateObject var  iPhoneConnexion  = WatchToIos()
    var body: some View {
        
            if iPhoneConnexion.gameBrain.joueurs.isEmpty {
                VStack {
                    Image(systemName: "iphone.badge.play").imageScale(.large)
                    Text("Merci de paramétrer le jeu sur l'iPhone")
                  
                   
                }
            }
            else{
                NavigationStack {
                NavigationLink(value: iPhoneConnexion.gameBrain, label: {
                    Text("Commencer le jeu")
                }).navigationDestination(for: GameBrain.self) { gameBrain in
                    EcranJeuxWatch(gameBrain: gameBrain)
                }

            }
        }
       
        
    }
}
#Preview {
    PageDemarrage()
}
