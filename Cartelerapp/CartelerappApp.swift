//
//  CartelerappApp.swift
//  Cartelerapp
//
//  Created by alp1 on 29/3/23.
//

import SwiftUI

@main
struct CartelerappApp: App {
    var body: some Scene {
        WindowGroup {

            TabView {

                NavigationView {
                    Cartelera()
                }
                .tabItem {
                    Label("Cartelera", systemImage: "popcorn")
                }

                Text("Buscador")
                    .tabItem {
                        Label("Buscador", systemImage: "magnifyingglass")
                    }
            }

        }
    }
}
