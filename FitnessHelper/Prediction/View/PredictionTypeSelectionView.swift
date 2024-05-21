//
//  PredictionTypeSelectionView.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/19/24.
//

import SwiftUI

struct PredictionTypeSelectionView: View {
    @State private var predictionType: PredictionTypeModel = .FITNESS
    @State private var showFoodDetectionView = false
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea(.all, edges: [.top, .bottom])
            
            VStack{
                Text("What kind of content do we detect?")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.txt)
                
                Spacer()
                
                HStack{
                    Button(action: {
                        predictionType = .FITNESS
                    }){
                        VStack{
                            Image(systemName: "dumbbell.fill")
                                .font(.title)
                                .foregroundStyle(Color.txt)
                            
                            Text("Fitness")
                                .foregroundStyle(Color.txt)
                        }.padding(20)
                    }
                    .buttonStyle(PushButtonNewMorphStyle(isSelected: predictionType == .FITNESS, foreground: Color.background))
                    
                    Spacer().frame(width: 20)
                    
                    Button(action: {
                        predictionType = .FOOD
                    }){
                        VStack{
                            Image(systemName: "carrot.fill")
                                .font(.title)
                                .foregroundStyle(Color.txt)
                            
                            Text("Food")
                                .foregroundStyle(Color.txt)
                        }.padding(20)
                    }
                    .buttonStyle(PushButtonNewMorphStyle(isSelected: predictionType == .FOOD, foreground: Color.background))
                }
                
                Spacer()
                
                Button(action: {
                    switch predictionType {
                    case .FITNESS:
                        break
                        
                    case .FOOD:
                        showFoodDetectionView = true
                    }
                }){
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
                .navigationTitle(Text("Select Prediction Type"))
                .fullScreenCover(isPresented: $showFoodDetectionView, content: {
                    FoodDetectionView()
                })
        }
    }
}

#Preview {
    PredictionTypeSelectionView()
}
