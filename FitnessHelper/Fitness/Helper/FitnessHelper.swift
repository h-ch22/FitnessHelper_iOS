//
//  FitnessHelper.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/19/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FitnessHelper: ObservableObject{
    @Published var weightHistory = [WeightDataModel]()
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    func getWeightHistory(completion: @escaping(_ result: Bool?) -> Void){
        weightHistory = []
        
        db.collection("Users").document(auth.currentUser?.uid ?? "").collection("Weights").getDocuments(){(querySnapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            if querySnapshot != nil && !querySnapshot!.isEmpty{
                for document in querySnapshot!.documents{
                    let date = document.documentID
                    let weight = document.data()["weight"] as? Int ?? 0
                    
                    self.weightHistory.append(WeightDataModel(date: date, weight: weight))
                }
                
                completion(true)
                return
            } else{
                completion(false)
                return
            }
        }
    }
    
    func setWeight(weight: Int, completion: @escaping(_ result: Bool?) -> Void){
        db.collection("Users").document(auth.currentUser?.uid ?? "").updateData(
            ["weight": weight]
        ){ error in
            if error != nil{
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM. dd. yyyy"
            
            self.db.collection("Users").document(self.auth.currentUser?.uid ?? "").collection("Weights").document(dateFormatter.string(from: Date())).setData(
                [
                    "weight": weight
                ]
            ){ error in
                if error != nil{
                    print(error?.localizedDescription)
                    completion(false)
                    return
                }
                
                self.weightHistory.append(WeightDataModel(date: dateFormatter.string(from: Date()), weight: weight))
                
                completion(true)
                return
            }
        }
    }
}
