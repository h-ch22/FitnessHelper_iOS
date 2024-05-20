//
//  HomeAlertTypeModel.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/19/24.
//

import Foundation

enum HomeAlertTypeModel: LocalizedError{
    case EMPTY_FIELD, ERROR
    
    var errorDescription: String?{
        switch self{
        case .EMPTY_FIELD: return String(localized: "Empty Field")
        case .ERROR: return String(localized: "Error")
        }
    }
    
    var recoverySuggestion: String?{
        switch self{
        case .EMPTY_FIELD: return String(localized: "Please enter weight.")
        case .ERROR: return String(localized: "An error occurred while processing requested action.\nPlease check your network status, or try later.")
        }
    }
}
