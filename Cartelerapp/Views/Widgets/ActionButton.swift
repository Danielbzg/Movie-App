//
//  ActionButton.swift
//  Cartelerapp
//
//  Created by Álvaro Murillo del Puerto on 3/5/23.
//

import SwiftUI

struct ActionButton: View {

    let icon: String
    let action: () -> Void

    var body: some View {

        Button(action: action, label: {
            Image(icon)
                .foregroundColor(.white)
        })
        .frame(minWidth: 50, minHeight: 50)
        .foregroundColor(.dsSecondary)
        .cornerRadius(8)
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {

        HStack {
            
            ActionButton(icon: "fullHeart", action: {})

            ActionButton(icon: "fullHeart", action: {})

            ActionButton(icon: "fullHeart", action: {})
        }
    }
}
