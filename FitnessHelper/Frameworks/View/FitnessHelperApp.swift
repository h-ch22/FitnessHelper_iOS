//
//  FitnessHelperApp.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/17/24.
//

import SwiftUI
import FirebaseCore
import SwiftData

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct FitnessHelperApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var modelContainer: ModelContainer = {
        let schema = Schema([AuthInfoModel.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch{
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            SignInView()
                .modelContainer(modelContainer)
        }.environmentObject(UserManagement())
    }
}
