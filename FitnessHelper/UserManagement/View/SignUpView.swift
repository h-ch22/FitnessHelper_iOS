//
//  SignUpView.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/17/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var displayName = ""
    @State private var birthDay = Date()
    @State private var weight = ""
    @State private var tall = ""
    
    @State private var weightUnit = ["kg", "lb"]
    @State private var selectedWeightUnit = "kg"
    
    @State private var tallUnit = ["cm", "ft"]
    @State private var selectedTallUnit = "cm"
    @State private var sex = SexTypeModel.MALE
    @State private var acceptEULA = false
    @State private var acceptPrivacyLicense = false
    @State private var acceptHumanExperiments = false
    
    @State private var showProgress = false
    @State private var showAlert = false
    @State private var alertModel: UserManagementAlertModel? = nil
    @State private var showMainView = false
    
    @State private var dateFormatter = DateFormatter()
    
    @StateObject private var helper = UserManagement()
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea(.all, edges: [.top, .bottom])
            
            ScrollView{
                VStack{
                    HStack {
                        Image(systemName: "at.circle.fill")
                        
                        TextField("E-Mail", text:$email)
                    }
                    .foregroundStyle(email == "" ? Color.gray : Color.accent)
                    .keyboardType(.emailAddress)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    
                    Spacer().frame(height: 20)

                    HStack {
                        Image(systemName: "key.fill")
                        
                        SecureField("Password", text:$password)
                    }
                    .foregroundStyle(password == "" ? Color.gray : Color.accent)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    
                    Spacer().frame(height: 20)

                    HStack {
                        Image(systemName: "key.fill")
                        
                        SecureField("Confirm Password", text:$confirmPassword)
                    }
                    .foregroundStyle(confirmPassword == "" ? Color.gray : Color.accent)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    
                    Spacer().frame(height: 20)

                    HStack {
                        Image(systemName: "person.fill")
                        
                        TextField("Display Name", text:$displayName)
                    }
                    .foregroundStyle(displayName == "" ? Color.gray : Color.accent)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    
                    Spacer().frame(height: 20)

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
                        
                        Picker("Weight Unit", selection: $selectedWeightUnit) {
                            ForEach(weightUnit, id: \.self){
                                Text($0)
                            }
                        }
                    }
                    
                    Spacer().frame(height: 20)

                    HStack{
                        HStack {
                            Image(systemName: "figure.stand")
                            
                            TextField("Tall", text:$tall)
                        }
                        .foregroundStyle(tall == "" ? Color.gray : Color.accent)
                        .keyboardType(.numberPad)
                        .padding(20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                        
                        Picker("Weight Unit", selection: $selectedTallUnit) {
                            ForEach(tallUnit, id: \.self){
                                Text($0)
                            }
                        }
                    }
                    
                    Spacer().frame(height: 20)
                    
                    DatePicker(selection: $birthDay, in: ...Date(), displayedComponents: .date, label: {
                        Text("Birthday")
                    })
                    
                    Spacer().frame(height: 20)

                    HStack{
                        Text("Sex")
                        
                        Spacer()
                        
                        Button(action: {
                            sex = .MALE
                        }){
                            Image(systemName: sex == .MALE ? "checkmark" : "circle")
                                .foregroundStyle(Color.txt)
                                .font(.caption)
                        }.buttonStyle(CircleNewMorphButtonStyle(foreground: Color.background, paddingValue: 5.0))
                        
                        Text("Male")
                        
                        Button(action: {
                            sex = .FEMALE
                        }){
                            Image(systemName: sex == .FEMALE ? "checkmark" : "circle")
                                .foregroundStyle(Color.txt)
                                .font(.caption)
                        }.buttonStyle(CircleNewMorphButtonStyle(foreground: Color.background, paddingValue: 5.0))
                        
                        Text("Female")
                    }
                    
                    Spacer().frame(height: 20)

                    HStack{
                        Button(action: {
                            acceptEULA.toggle()
                        }){
                            Image(systemName: acceptEULA ? "checkmark" : "circle")
                                .foregroundStyle(Color.txt)
                                .font(.caption)
                        }.buttonStyle(CircleNewMorphButtonStyle(foreground: Color.background, paddingValue: 5.0))
                        
                        Text("Accept End User License Agreement (EULA)")
                        
                        Spacer()
                        
                        Button(action: {}){
                            Text("Read")
                        }
                    }
                    
                    Spacer().frame(height: 20)

                    HStack{
                        Button(action: {
                            acceptPrivacyLicense.toggle()
                        }){
                            Image(systemName: acceptPrivacyLicense ? "checkmark" : "circle")
                                .foregroundStyle(Color.txt)
                                .font(.caption)
                        }.buttonStyle(CircleNewMorphButtonStyle(foreground: Color.background, paddingValue: 5.0))
                        
                        Text("Accept Personal information collection and processing policy")
                        
                        Spacer()
                        
                        Button(action: {}){
                            Text("Read")
                        }
                    }
                    
                    Spacer().frame(height: 20)

                    HStack{
                        Button(action: {
                            acceptHumanExperiments.toggle()
                        }){
                            Image(systemName: acceptHumanExperiments ? "checkmark" : "circle")
                                .foregroundStyle(Color.txt)
                                .font(.caption)
                        }.buttonStyle(CircleNewMorphButtonStyle(foreground: Color.background, paddingValue: 5.0))
                        
                        Text("Accept contents of human experiments")
                        
                        Spacer()
                        
                        Button(action: {}){
                            Text("Read")
                        }
                    }
                    
                    Spacer().frame(height: 20)
                    
                    if showProgress{
                        DotProgressView()
                    } else{
                        Button(action: {
                            if email == "" || password == "" || confirmPassword == "" || displayName == "" || weight == "" || tall == ""{
                                alertModel = .EMPTY_FIELD
                                showAlert = true
                            } else if !email.contains("@"){
                                alertModel = .INCORRECT_EMAIL_TYPE
                                showAlert = true
                            } else if password != confirmPassword{
                                alertModel = .PASSWORD_MISMATCH
                                showAlert = true
                            } else if password.count < 8{
                                alertModel = .WEAK_PASSWORD
                                showAlert = true
                            } else if !acceptEULA || !acceptPrivacyLicense || !acceptHumanExperiments{
                                alertModel = .LICENSE_NOT_ACCEPTED
                                showAlert = true
                            } else{
                                showProgress = true
                                dateFormatter.dateFormat = "MM.dd.yyyy"
                                
                                helper.signUp(email: email, password: password, displayName: displayName, weight: weight, tall: tall, birthday: dateFormatter.string(from: birthDay), weightUnit: selectedWeightUnit, tallUnit: selectedTallUnit, sex: sex, completion: { result in
                                    guard let result = result else{return}
                                    
                                    showProgress = false
                                    
                                    if !result{
                                        alertModel = .ERROR
                                        showAlert = true
                                    } else{
                                        showMainView = true
                                    }
                                })
                            }
                        }){
                            HStack{
                                Spacer()
                                
                                Text("Sign Up")
                                    .foregroundStyle(Color.txt)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color.txt)
                                
                                Spacer()
                            }

                        }.buttonStyle(NewMorphButtonStyle(foreground: .background))
                    }

                }.padding(20)
                    .navigationTitle(Text("Sign Up"))
                    .alert(isPresented: $showAlert, error: alertModel){ error in
                        Button("OK"){
                            showAlert = false
                        }
                    } message: { error in
                        Text(error.recoverySuggestion ?? "")
                    }
            }            
            .fullScreenCover(isPresented: $showMainView, content: {
                MainView()
            })
        }
    }
}

#Preview {
    SignUpView()
}
