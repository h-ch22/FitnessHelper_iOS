//
//  UserManagementAlertModel.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/17/24.
//

import Foundation

enum UserManagementAlertModel: LocalizedError{
    case EMPTY_FIELD, USER_NOT_EXISTS, INCORRECT_EMAIL_TYPE, PASSWORD_MISMATCH, WEAK_PASSWORD, ERROR, LICENSE_NOT_ACCEPTED
    
    var errorDescription: String?{
        switch self{
        case .EMPTY_FIELD: return String(localized: "Empty Field")
        case .USER_NOT_EXISTS: return String(localized: "Unknown User")
        case .INCORRECT_EMAIL_TYPE: return String(localized: "Incorrect E-Mail Type")
        case .PASSWORD_MISMATCH: return String(localized: "Password Mismatch")
        case .WEAK_PASSWORD: return String(localized: "Weak Password")
        case .ERROR: return String(localized: "Error")
        case .LICENSE_NOT_ACCEPTED: return String(localized: "Check License Agreements")
        }
    }
    
    var recoverySuggestion: String?{
        switch self{
        case .EMPTY_FIELD: return String(localized: "Please enter all fields.")
        case .USER_NOT_EXISTS: return String(localized: "Check the information you entered again, or check the network status.")
        case .INCORRECT_EMAIL_TYPE: return String(localized: "Please enter correct E-Mail Type")
        case .PASSWORD_MISMATCH: return String(localized: "Please double-check that the password and password verification match.")
        case .WEAK_PASSWORD: return String(localized: "Please enter a password of at least 8 digits for safety.")
        case .ERROR: return String(localized: "An error occurred while processing requested action.\nPlease check your network status, or try later.")
        case .LICENSE_NOT_ACCEPTED: return String(localized: "Please read and accept all licenses.")
        }
    }
}
