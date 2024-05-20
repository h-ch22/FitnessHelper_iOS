//
//  HomeView.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/19/24.
//

import SwiftUI
import Charts

struct HomeView: View {
    @EnvironmentObject var helper: UserManagement
    @StateObject private var fitnessHelper = FitnessHelper()
    
    @State private var month = ""
    @State private var day = ""
    @State private var dayOfWeek = ""
    @State private var today = ""
    @State private var weight = ""
    
    @State private var showProgress = true
    @State private var alertModel: HomeAlertTypeModel? = nil
    @State private var showAlert = false
    
    private let dateFormatter = DateFormatter()

    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea(.all, edges: [.top, .bottom])
            
            ScrollView{
                VStack{
                    HStack{
                        Text("Hello,\n\(helper.userInfo?.displayName ?? "") 😆")
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing){
                            Text("\(month).\(day)")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                            
                            Text(dayOfWeek)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.txt)
                        }
                    }
                    
                    Spacer().frame(height: 20)
                    
                    HStack{
                        Text("✨ Recommended")
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    
                    Spacer().frame(height: 10)
                    
                    ScrollView(.horizontal){
                        HStack{
                            Button(action: {}){
                                HomeRecommendedActionListModel(title: String(localized: "Start Prediction"),
                                                               headLine: String(localized: "concerns about fitness or eating habits?"),
                                                               icon: "dumbbell.fill",
                                                               color: Color.red)
                            }.foregroundStyle(Color.white)
                            
                            
                            
                            Button(action: {}){
                                HomeRecommendedActionListModel(title: String(localized: "Check Statistics"),
                                                               headLine: String(localized: "gather the achievements we've made so far?"),
                                                               icon: "list.bullet.clipboard.fill",
                                                               color: Color.blue)
                            }.foregroundStyle(Color.white)
                        }
                    }
                    
                    Spacer().frame(height: 20)

                    if showProgress{
                        DotProgressView()
                    } else{
                        if !fitnessHelper.weightHistory.contains(where: {$0.date == today}){
                            VStack{
                                Text("Set today's weight")
                                    .fontWeight(.semibold)
                                
                                HStack{
                                    HStack {
                                        Image(systemName: "gauge.with.dots.needle.bottom.50percent")
                                        
                                        TextField("Weights", text:$weight)
                                    }
                                    .foregroundStyle(weight == "" ? Color.gray : Color.accent)
                                    .keyboardType(.numberPad)
                                    .padding(20)
                                    .background(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(radius: 5)
                                    
                                    Text(helper.userInfo?.weightUnit ?? "kg")
                                }
                                
                                Button(action: {
                                    if weight == "" {
                                        alertModel = .EMPTY_FIELD
                                        showAlert = true
                                    } else{
                                        showProgress = true
                                        
                                        fitnessHelper.setWeight(weight: Int(weight) ?? 0, completion: { result in
                                            guard let result = result else {return}
                                            
                                            if !result{
                                                alertModel = .ERROR
                                                showAlert = true
                                            }
                                            
                                            showProgress = false
                                        })
                                    }
                                }){
                                    Image(systemName: "checkmark")
                                }.buttonStyle(CircleNewMorphButtonStyle(foreground: Color.background, paddingValue: 15))
                            }.padding(20)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                            
                        } else{
                            HStack{
                                Text("WEIGHTS LOG")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.gray)
                                
                                Spacer()
                            }
                            
                            Spacer().frame(height: 10)
                            
                            Chart(fitnessHelper.weightHistory, id: \.date){
                                LineMark(x: .value(String(localized: "Date"), $0.date),
                                         y: .value(String(localized: "Weights"), $0.weight))
                            }
                        }
                    }
                    
                    Spacer()
                }.padding(20)
                    .navigationTitle(Text("Home"))
                    .onAppear{
                        dateFormatter.dateFormat = "MM. dd. E"
                        
                        let dateAsString = dateFormatter.string(from: Date())
                        
                        month = String(dateAsString.split(separator: ". ")[0])
                        day = String(dateAsString.split(separator: ". ")[1])
                        dayOfWeek = String(dateAsString.split(separator: ". ")[2])
                        
                        dateFormatter.dateFormat = "MM. dd. yyyy"
                        today = dateFormatter.string(from: Date())
                        
                        #if !targetEnvironment(simulator)
                        fitnessHelper.getWeightHistory(){ result in
                            guard let result = result else{return}
                            
                            showProgress = false
                            
                            if !result{
                                alertModel = .ERROR
                                showAlert = true
                            }
                        }
                        
                        #else
                        showProgress = false
                        
                        #endif
                    }
                    .alert(isPresented: $showAlert, error: alertModel){ error in
                        Button("OK"){
                            showAlert = false
                        }
                    } message: { error in
                        Text(error.recoverySuggestion ?? "")
                    }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(UserManagement())
}
