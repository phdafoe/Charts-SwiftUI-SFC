//
//  TabbedStartView.swift
//  Charts-SwiftUI
//
//  Created by TECDATA on 2023-03-09
//

import SwiftUI

struct TabbedStartView: View {
    var body: some View {
        TabView {
            CombinedChrtView()
                .tabItem {
                    Image("StackedBarLine")
                    Text("Line Chart")
                }
        }
    }
}

struct TabbedStartView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedStartView()
    }
}
