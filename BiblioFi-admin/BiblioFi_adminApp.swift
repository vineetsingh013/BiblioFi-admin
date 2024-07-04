//
//  BiblioFi_adminApp.swift
//  BiblioFi-admin
//
//  Created by Vineet Chaudhary on 03/07/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct BiblioFi_adminApp: App {
    var body: some Scene {
        WindowGroup {
            LoginPage()
        }
    }
}
