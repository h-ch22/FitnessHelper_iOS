//
//  MainView.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/17/24.
//

import SwiftUI

struct MainView: View {
    @State private var device = UIDevice.current.userInterfaceIdiom
    @State private var selectedIndex = 0
    @State private var showModal = false
        
    private let icons = ["house.fill", "carrot.fill", "plus", "calendar.badge.clock", "ellipsis.circle.fill"]
    private let titles = [String(localized: "Home"), String(localized: "Diet"), "Inspection", String(localized: "Statistics"), String(localized: "More")]
    
    var body: some View {
        if device == .phone{
            NavigationStack{
                VStack{
                    ZStack{
                        switch selectedIndex{
                        case 0: HomeView()
                        case 1: DietView()
                        case 3: StatisticsView()
                        case 4: MoreView()
                        default: HomeView()
                        }
                    }
                    
                    Spacer()
                    
                    HStack{
                        ForEach(0..<5, id:\.self){number in
                            Spacer()
                            
                            Button(action: {
                                if number == 2{
                                    self.showModal = true
                                }
                                
                                else{
                                    selectedIndex = number
                                }
                            }){
                                if number == 2{
                                    Image(systemName: icons[number])
                                        .font(.system(
                                            size: 25,
                                            weight: .regular,
                                            design: .default
                                        ))
                                        .foregroundStyle(Color.txt)
                                        .frame(width : 60, height : 60)
                                        .background(
                                            Circle()
                                                .fill(Color.background)
                                                .shadow(color: Color.shadowStart.opacity(0.2), radius: 10, x: 10, y: 10)
                                                .shadow(color: Color.shadowEnd.opacity(0.7), radius: 10, x: -5, y: -5)
                                        )
                                }
                                
                                else{
                                    VStack{
                                        Image(systemName: icons[number])
                                            .font(.system(
                                                size: 20,
                                                weight: .regular,
                                                design: .default
                                            ))
                                            .foregroundStyle(selectedIndex == number ? Color.txt : Color.gray)
                                        
                                        Spacer().frame(height: 5)
                                        
                                        if selectedIndex == number{
                                            Text(titles[number])
                                                .font(.caption)
                                                .foregroundStyle(Color.txt)
                                        }
                                    }.padding(selectedIndex == number ? 10 : 0)
                                        .background(RoundedRectangle(cornerRadius: selectedIndex == number ? 15 : 0).foregroundStyle(selectedIndex == number ? Color.background : Color.clear).opacity(0.6))
                                }
                                
                            }
                            
                            Spacer()
                        }
                    }.padding(10)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding([.horizontal], 5)
                        .animation(.easeInOut)
                }
                .sheet(isPresented: $showModal, content: {
                    PredictionView()
                })
                .background(Color.background.ignoresSafeArea(.all, edges: [.top, .bottom]))
                
            }
            .toolbar(.hidden)
            
        } else if device == .pad{
            NavigationSplitView(sidebar: {
                VStack{
                    ForEach(icons.indices, id: \.self){ idx in
                        if idx != 2{
                            Button(action: {
                                selectedIndex = idx
                            }){
                                HStack{
                                    Image(systemName: icons[idx])
                                    Text(titles[idx])
                                    
                                    Spacer()
                                }.padding(15)
                                    .foregroundStyle(selectedIndex == idx ? Color.white : Color.txt)
                                    .background(RoundedRectangle(cornerRadius: 15).foregroundStyle(selectedIndex == idx ? Color.accent : Color.btn))
                            }
                        }
                    }
                    
                    Spacer()
                }.padding(10)
                    .navigationTitle(Text("Fitness Helper"))
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing, content: {
                            Button(action: {
                                showModal = true
                            }){
                                Image(systemName: "plus")
                            }
                        })
                    }
                    .background(.ultraThinMaterial)
                    .sheet(isPresented: $showModal, content: {
                        PredictionView()
                    })
                
            }, detail: {
                switch selectedIndex{
                case 0: HomeView()
                case 1: DietView()
                case 3: StatisticsView()
                case 4: MoreView()
                default: HomeView()
                }
            })
        }
    }
}

#Preview {
    MainView()
}
