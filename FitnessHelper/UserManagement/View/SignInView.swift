//
//  SignInView.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/17/24.
//

import SwiftUI
import SwiftData

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showProgress = false
    @State private var showAlert = false
    @State private var alertModel: UserManagementAlertModel? = nil
    @State private var showMainView = false
    
    @EnvironmentObject var helper: UserManagement
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea(.all, edges: [.top, .bottom])
                
                VStack{
                    Image("ic_main")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                    
                    Text("__Fitness__ Helper")
                        .font(.title2)
                    
                    Spacer()
                    
                    Group{
                        HStack {
                            Image(systemName: "at.circle.fill")
                            
                            TextField("E-Mail", text:$email)
                        }
                        .foregroundStyle(email == "" ? Color.gray : Color.accent)
                        .padding(20)
                        .keyboardType(.emailAddress)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                        
                        Spacer().frame(height : 20)
                        
                        HStack {
                            Image(systemName: "key.fill")
                            
                            SecureField("Password", text:$password)
                        }
                        .foregroundStyle(password == "" ? Color.gray : Color.accent)
                        .padding(20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                    }
                    
                    Spacer().frame(height: 20)
                    
                    if showProgress{
                        DotProgressView()
                    } else{
                        Button(action: {
                            if email == "" || password == ""{
                                alertModel = .EMPTY_FIELD
                                showAlert = true
                            } else if !email.contains("@"){
                                alertModel = .INCORRECT_EMAIL_TYPE
                                showAlert = true
                            } else{
                                showProgress = true
                                
                                helper.signIn(email: email, password: password, completion: { result in
                                    guard let result = result else{return}
                                    
                                    showProgress = false
                                    
                                    if !result{
                                        alertModel = .USER_NOT_EXISTS
                                        showAlert = true
                                    } else{
                                        showMainView = true
                                    }
                                })
                            }
                        }){
                            HStack{
                                Spacer()
                                
                                Text("Sign In")
                                    .foregroundStyle(Color.txt)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color.txt)
                                
                                Spacer()
                                
                            }
                        }.buttonStyle(NewMorphButtonStyle(foreground: .background))
                    }
                    
                    Spacer().frame(height: 20)
                    
                    HStack{
                        NavigationLink(destination: EmptyView()){
                            Text("Forget Password?")
                                .font(.caption)
                                .foregroundStyle(Color.txt)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: SignUpView()){
                            Text("Sign Up")
                                .font(.caption)
                                .foregroundStyle(Color.txt)
                        }
                    }
                    
                    Spacer()
                    
                    Text("© 2024 Changjin Ha.\nAll Rights Reserved.")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.center)
                }.padding(20)
                    .navigationTitle(Text("Sign In"))
                    .toolbar(.hidden)
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
    SignInView()
}
