//
//  StylesNavbar.swift
//  Cartelerapp
//
//  Created by Daniel Boza García on 4/5/23.
//
import SwiftUI
import UIKit
import Foundation


//Establecimiento de colores del Navbar
extension UINavigationBarAppearance {
    func navigationBarColor(_ backgroundColor: UIColor?, titleColor: UIColor? = nil) -> Self {
        configureWithTransparentBackground()
        backgroundColor.map { self.backgroundColor = $0 }
        titleColor.map { self.titleTextAttributes = [.foregroundColor: $0] }
        return self
    }
}
