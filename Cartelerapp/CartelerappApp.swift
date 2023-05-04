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
    init() {
        // configura la apariencia del NavBar globalmente para toda la aplicación
        let appearanceNavBar = UINavigationBarAppearance().navigationBarColor(UIColor.dsMainUI, titleColor: UIColor.white)
        UINavigationBar.appearance().standardAppearance = appearanceNavBar
        
        let appearanceTabBar = UITabBarAppearance()
        appearanceTabBar.backgroundColor = UIColor.dsMainUI
        UITabBar.appearance().standardAppearance = appearanceTabBar
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.blue // establece el color de fondo del ZStack
                    .ignoresSafeArea()
                TabView {
                    
                    NavigationView {
                        CarteleraView()
                    }
                    .tabItem {
                        Label("Movies", image: "logoSmall")
                    }
                    
                    NavigationView {
                        SearchView()
                    }
                    
                    .tabItem {
                        Label("Buscador", systemImage: "magnifyingglass")
                    }
                    
                    NavigationView {
                        SearchView()
                    }
                    
                    .tabItem {
                        Label("Mis listas", systemImage: "text.alignleft")
                    }
                }
            }
        }
    }
}
