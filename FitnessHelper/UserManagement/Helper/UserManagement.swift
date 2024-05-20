//
//  UserManagement.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/17/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserManagement: ObservableObject{
    @Published var userInfo: UserInfoModel? = nil
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    func signIn(email: String, password: String, completion: @escaping(_ result: Bool?) -> Void){
        auth.signIn(withEmail: email, password: password, completion: { result, error in
            if error != nil{
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            self.getUserInfo{ result in
                completion(result)
                return
            }
        })
    }
    
    func signUp(email: String, password: String, displayName: String, weight: String, tall: String, birthday: String, weightUnit: String, tallUnit: String, sex: SexTypeModel, completion: @escaping(_ result: Bool?) -> Void){
        auth.createUser(withEmail: email, password: password, completion: { result, error in
            if error != nil{
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            self.db.collection("Users").document(self.auth.currentUser?.uid ?? "").setData([
                "email": AES256Util.encrypt(string: email),
                "displayName": AES256Util.encrypt(string: displayName),
                "weight": Int(weight) ?? 0,
                "tall": Int(tall) ?? 0,
                "birthday": AES256Util.encrypt(string: birthday),
                "weightUnit": weightUnit,
                "tallUnit": tallUnit,
                "sex": sex == .MALE ? "MALE" : "FEMALE"
            ]){ error in
                if error != nil{
                    print(error?.localizedDescription)
                    completion(false)
                    return
                }
                
                self.userInfo = UserInfoModel(uid: self.auth.currentUser?.uid ?? "", email: email, displayName: displayName, birthday: birthday, weight: Int(weight) ?? 0, weightUnit: weightUnit, tall: Int(tall) ?? 0, tallUnit: tallUnit, sex: sex)
                
                completion(true)
                return
            }
        })
    }
    
    private func getUserInfo(completion: @escaping(_ result: Bool?) -> Void){
        db.collection("Users").document(auth.currentUser?.uid ?? "").getDocument(){ document, error in
            if error != nil{
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            if document != nil && document!.exists{
                let email = document!.get("email") as? String ?? ""
                let displayName = document!.get("displayName") as? String ?? ""
                let weight = document!.get("weight") as? Int ?? 0
                let tall = document!.get("tall") as? Int ?? 0
                let birthday = document!.get("birthday") as? String ?? ""
                let weightUnit = document!.get("weightUnit") as? String ?? ""
                let tallUnit = document!.get("tallUnit") as? String ?? ""
                let sex = document!.get("sex") as? String ?? ""
                
                self.userInfo = UserInfoModel(uid: self.auth.currentUser?.uid ?? "", email: AES256Util.decrypt(encoded: email), displayName: AES256Util.decrypt(encoded: displayName), birthday: AES256Util.decrypt(encoded: birthday), weight: weight, weightUnit: weightUnit, tall: tall, tallUnit: tallUnit, sex: sex == "MALE" ? .MALE : .FEMALE)
                
                completion(true)
                return
            } else{
                completion(false)
                return
            }
        }
    }
}
