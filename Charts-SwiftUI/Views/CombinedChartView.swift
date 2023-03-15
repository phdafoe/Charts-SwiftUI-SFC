//
//  CombinedChartView.swift
//  Charts-SwiftUI
//
//  Created by TECDATA on 2023-03-09
//

import SwiftUI
import Charts

struct CombinedChrtView: View {
    @State private var quarter: Int = 0
    var body: some View {
        Group{
            VStack {
                HStack(alignment: .top){
                    Text("Evolución 22-23")
                        .font(.title3)
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Rectangle().frame(width: 20, height: 1).foregroundColor(.blue)
                            Text("Evolución")
                                .font(.caption)
                                .bold()
                        }
                        HStack{
                            Rectangle().frame(width: 20, height: 1).foregroundColor(.gray)
                            Text("Gasto medio")
                                .font(.caption)
                        }
                    }
                }
                CombinedChart(lineEntries: Sale.TransactionsFor(Sale.allSales,
                                                                quarter: quarter),
                              average: 300,
                              quarter: $quarter)
                .frame(height: 400)
            }.padding(.horizontal)
        }
        .background(Color.white)
        .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 1, y: 3)
        
    }
}

struct CombinedChrtView_Previews: PreviewProvider {
    static var previews: some View {
        CombinedChrtView()
    }
}
