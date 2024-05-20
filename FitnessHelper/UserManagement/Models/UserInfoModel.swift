//
//  UserInfoModel.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/17/24.
//

import Foundation

struct UserInfoModel: Hashable{
    let uid: String
    let email: String
    let displayName: String
    let birthday: String
    let weight: Int
    let weightUnit: String
    let tall: Int
    let tallUnit: String
    let sex: SexTypeModel
    
    init(uid: String, email: String, displayName: String, birthday: String, weight: Int, weightUnit: String, tall: Int, tallUnit: String, sex: SexTypeModel) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.birthday = birthday
        self.weight = weight
        self.weightUnit = weightUnit
        self.tall = tall
        self.tallUnit = tallUnit
        self.sex = sex
    }
}
