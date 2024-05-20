//
//  PredictionView.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/19/24.
//

import SwiftUI

struct PredictionView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea(.all, edges: [.top, .bottom])
                
                VStack{
                    Spacer()
                    
                    IntroductionListModel(
                        icon: "camera.viewfinder",
                        title: String(localized: "Realtime Prediction"),
                        contents: String(localized: "You can detect food and exercise posture in real time using cameras and deep learning technology.")
                    )
                    
                    Spacer().frame(height: 20)
                    
                    IntroductionListModel(
                        icon: "checkmark.circle.fill",
                        title: String(localized: "Coach yourself"),
                        contents: String(localized: "With AI, you can correct the right fitness posture and nutrient balance.")
                    )
                    
                    Spacer().frame(height: 20)
                    
                    IntroductionListModel(
                        icon: "chart.xyaxis.line",
                        title: String(localized: "Check Statistics"),
                        contents: String(localized: "On the Statistics tab, you can check the fitness posture and statistics of the food you ate.")
                    )
                    
                    Spacer()
                    
                    NavigationLink(destination: PredictionTypeSelectionView()){
                        HStack{
                            Spacer()
                            
                            Text("Next")
                                .foregroundStyle(Color.txt)
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.txt)
                            
                            Spacer()
                            
                        }
                    }.buttonStyle(NewMorphButtonStyle(foreground: .background))
                    
                }.padding(20)
                    .navigationTitle(Text("Prediction"))
                    .toolbar{
                        ToolbarItem(placement: .topBarLeading, content: {
                            Button("Close"){
                                self.dismiss()
                            }
                        })
                    }
            }
        }
    }
}

#Preview {
    PredictionView()
}
