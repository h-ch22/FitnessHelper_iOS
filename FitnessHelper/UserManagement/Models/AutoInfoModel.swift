//
//  AutoInfoModel.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/19/24.
//

import Foundation
import SwiftData

@Model
class AuthInfoModel {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
