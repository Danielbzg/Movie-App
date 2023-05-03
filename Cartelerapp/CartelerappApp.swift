//
//  CartelerappApp.swift
//  Cartelerapp
//
//  Created by alp1 on 29/3/23.
//

import SwiftUI
import FirebaseCore
import FirebaseCrashlytics

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        return true
    }
}
    
    
    @main
    struct CartelerappApp: App {
        //register app delegate for firebase setup
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
        var body: some Scene {
            WindowGroup {
                
                TabView {
                    
                    NavigationView {
                        CarteleraView()
                    }
                    .tabItem {
                        Label("Cartelera", systemImage: "ticket")
                    }
                    
                    NavigationView {
                        SearchView()
                    }
                    
                    .tabItem {
                        Label("Buscador", systemImage: "magnifyingglass")
                    }
                }
            }
        }
    }
