//
//  EcranDejeux.swift
//  molky2
//
//  Created by Ezequiel Gomes on 01/02/2024.
//

import SwiftUI

struct EcranDejeux: View {
    @StateObject var gameBrain : GameBrain
    @State var scoreEnCoursValidation = 0
    @State var showEcranClassementFin = false
    @State var showEcranClassementEnCours = false
    var ismodern : Bool?
    var molkyGridControler = MolkyGridController()
    var body: some View {
        
        VStack {
            Text("Tour n°\(gameBrain.nbtour+1)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(.semibold)
            
            HStack {
                Circle().frame(width: 20).foregroundStyle(Color("Color\(gameBrain.numeroJoueurEnCours+1)"))
                Text("Joueur :").font(.system(size: 18))
                Text("\(gameBrain.joueurs[gameBrain.numeroJoueurEnCours].nom),").font(.system(size: 22)).bold()
                
                Text("Score actuel :").font(.system(size: 18))
                Text("\(gameBrain.joueurs[gameBrain.numeroJoueurEnCours].score)").font(.system(size: 22)).bold()
            }.padding()
            Spacer()
            
            MolkyGrid(molkyGridControler: molkyGridControler, ScoreEnCours: $scoreEnCoursValidation, ismodern: ismodern).frame(width: 350, height: 250).padding()
            Spacer()
            //                HStack {
            //                    Text("Score en cours de validation :")
            //                    Text("\(scoreEnCoursValidation)")
            //                }.padding()
            
            Button("Valider : \(scoreEnCoursValidation.description)") {
                withAnimation {
                    gameBrain.valideTourJoueur(scoreJoueur: scoreEnCoursValidation)
                    molkyGridControler.reset()
                    scoreEnCoursValidation = 0
                }
                
                
            }.buttonStyle(.bordered).font(.system(size: 30)).padding()
            
            
            
            
            
            
        }.navigationDestination(isPresented: $showEcranClassementFin, destination: {
            EcranClassementFin(findujeux: gameBrain.message.arretJeux, joueurs: gameBrain.exportJoueur())
        }).navigationBarBackButtonHidden(true)
            .alert(gameBrain.message.message, isPresented: $gameBrain.alert) {
                Button("OK") {
                    if gameBrain.message.arretJeux{
                        showEcranClassementFin.toggle()
                    }
                    
                }
            }
        
            .sheet(isPresented: $showEcranClassementEnCours, content: {
                EcranClassementFin(findujeux: gameBrain.message.arretJeux, joueurs: gameBrain.exportJoueur())
            }).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
        
            .toolbar(content: {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showEcranClassementEnCours.toggle()
                    } label: {
                        Label("Voir le classement", systemImage: "list.star")
                        
                    }
                }
                
                
            })
    }
}

#Preview {
    NavigationStack {
        EcranDejeux(gameBrain: GameBrain(nomJoueurs: ["Jakie","David"], isOne: true))
    }
}

