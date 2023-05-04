//
//  StylesNavbar.swift
//  Cartelerapp
//
//  Created by alp1 on 4/5/23.
//
import SwiftUI
import UIKit
import Foundation



extension UINavigationBarAppearance {
    func navigationBarColor(_ backgroundColor: UIColor?, titleColor: UIColor? = nil) -> Self {
        configureWithTransparentBackground()
        backgroundColor.map { self.backgroundColor = $0 }
        titleColor.map { self.titleTextAttributes = [.foregroundColor: $0] }
        return self
    }
}
