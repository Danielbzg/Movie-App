//
//  Grid.swift
//  Cartelerapp
//
//  Created by alp1 on 3/4/23.
//

import SwiftUI

struct GridPrueba: View {
    var body: some View {
        var elements = 1...500
        let gridItems = [GridItem(.fixed(100)),
                         GridItem(.fixed(100))]
        ScrollView {
        LazyVGrid(columns: gridItems, content: {
            ForEach(elements, id: \.self) { element in
                Text("\(element)")
            }
        })
        }
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        GridPrueba()
    }
}
