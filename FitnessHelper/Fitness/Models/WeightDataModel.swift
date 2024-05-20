//
//  WeightsDataModel.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/19/24.
//

import Foundation

struct WeightDataModel: Hashable, Identifiable{
    var id = UUID()
    
    let date: String
    let weight: Int
    
    init(date: String, weight: Int) {
        self.date = date
        self.weight = weight
    }
}
