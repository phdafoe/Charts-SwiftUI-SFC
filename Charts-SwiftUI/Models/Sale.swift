//
//  Sale.swift
//  Charts-SwiftUI
//
//  Created by TECDATA on 2023-03-09
//

import Charts
import Foundation


struct Sale {
    enum Month:Int {
        case jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec
    }
    
    let month: Month
    let units: Double
    let transaction: Double
    
    var quarter: Int {
        switch month {
        case .jan, .feb, .mar:
            return 1
        case .apr, .may, .jun:
            return 2
        case .jul, .aug, .sep:
            return 3
        default:
            return 4
        
        }
    }
    var xValue: Double {
        Double(month.rawValue)
    }
    
    static func UnitsFor(_ sales: [Sale], quarter: Int) -> [BarChartDataEntry] {
        var quarterlySales = sales
        var adjustment = 0
        if quarter != 0 {
            quarterlySales = sales.filter{$0.quarter == quarter}
            adjustment = 3 * quarter - 3
        }
        
        return quarterlySales.map { BarChartDataEntry(x: $0.xValue - Double(adjustment), y: $0.units)}
    }
    
    static func TransactionsFor(_ sales: [Sale], quarter: Int) -> [ChartDataEntry] {
        var quarterlySales = sales
        var adjustment = 0
        if quarter != 0 {
            quarterlySales = sales.filter{$0.quarter == quarter}
            adjustment = 3 * quarter - 3
        }
        return quarterlySales.map { ChartDataEntry(x: $0.xValue - Double(adjustment), y: $0.transaction)}
    }
    
    
    static func monthsToDisplayForQuarter(_ quarter: Int) -> [String] {
        let months =  ["Ene","Feb","Mar","Abr","May","Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
        switch quarter {
        case 0:
            return months
        case 1:
            return Array(months[0..<3])
        case 2:
            return Array(months[3..<6])
        case 3:
            return Array(months[6..<9])
        default:
            return Array(months[9..<12])
        }
    }
 
    static var allSales: [Sale] {
        [
            Sale(month: .jan, units: 50, transaction: 65.98),
            Sale(month: .feb, units: 100, transaction: 123.23),
            Sale(month: .mar, units: 30, transaction: 43.3),
            Sale(month: .apr, units: 110, transaction: 900.0),
            Sale(month: .may, units: 90, transaction: 100.34),
            Sale(month: .jun, units: 150, transaction: 567),
            Sale(month: .jul, units: 25, transaction: 456.23),
            Sale(month: .aug, units: 200, transaction: 23.34),
            Sale(month: .sep, units: 15, transaction: 78.56),
            Sale(month: .oct, units: 200, transaction: 678),
            Sale(month: .nov, units: 45, transaction: 45),
            Sale(month: .dec, units: 100, transaction: 678.7)
        ]
    }
    
}
