//
//  inscriptionDesParticipant.swift
//  molky2
//
//  Created by Ezequiel Gomes on 09/01/2024.
//

import SwiftUI

struct InscriptionDesParticipant: View {
    @State  var montreConnecte : WatchConnector = WatchConnector()
    var nbjoueur : Int
    var isOn : Bool
    var ismodern : Bool?
    @State  var noms : [String]
    @State var disabled = true
    @FocusState private var focusedField: String?
    @State private var affichageAppleWatch = true
    
    init(nbjoueur : Int, isOn : Bool, ismodern : Bool?) {
        self.nbjoueur = nbjoueur
        self.noms = Array(repeating: "", count: nbjoueur)
        self.isOn = isOn
        self.ismodern = ismodern
    }
    
    var body: some View {
        VStack {
            if affichageAppleWatch{
                ScrollView {
                    ForEach (0..<nbjoueur, id: \.self){ i in
                        TextField(" prénom joueur n°\(i+1) ", text: $noms[i]).autocorrectionDisabled(true).padding().id("TextField\(i)")
                            .focused($focusedField, equals: "TextField\(i)")
                        
                    }.onSubmit {
                        checkChamps()
                        
                    }
                    //Spacer()
                    .navigationTitle("Nom des joueurs")
                    
                }
                HStack(spacing : 50) {
                    if montreConnecte.session.isReachable {
                        Button("Jouer sur Apple Watch ") {
                            montreConnecte.sendtoWatch(nomJoueur: noms, isOne: isOn)
                            affichageAppleWatch.toggle()
                        }.disabled(disabled).buttonStyle(.borderedProminent)
                    }
                    
                    NavigationLink(value: GameBrain(nomJoueurs: noms, isOne: isOn)) {
                        Text("Suivant")
                    }.disabled(disabled).buttonStyle(.borderedProminent)
                        .navigationDestination(for: GameBrain.self) { game in
                            EcranDejeux(gameBrain: game,ismodern: ismodern)
                        }
                }
                
            }
            else {
                Text(" Le jeux s'est lancé sur l'Apple Watch")
            }
            
            
        }.onAppear(){
            focusedField = "TextField0"
        }
        
        
    }
    
    func checkChamps()  {
        for i in 0 ... noms.count-1 {
            
            if noms[i] == ""{
                disabled = true
                focusedField = "TextField\(i)"
                return
            }
            
            disabled = false
            
        }
    }
}


#Preview {
    InscriptionDesParticipant(nbjoueur: 5, isOn: true, ismodern: nil)
}
