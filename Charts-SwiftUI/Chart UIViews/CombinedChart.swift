//
//  CombinedChart.swift
//  Charts-SwiftUI
//
//  Created by TECDATA on 2023-03-09
//

import Charts
import SwiftUI

struct CombinedChart: UIViewRepresentable {
    var lineEntries : [ChartDataEntry]
    @Binding var quarter: Int
    func makeUIView(context: Context) -> CombinedChartView {
        return CombinedChartView()
    }
    
    func updateUIView(_ uiView: CombinedChartView, context: Context) {
        setChartData(uiView)
        configureChart(uiView)
        formatXAxis(uiView.xAxis)
        uiView.notifyDataSetChanged()
    }
    
    func setChartData(_ combinedChart: CombinedChartView) {
        let lineDataSet = LineChartDataSet(entries: lineEntries)
        let lineChartData = LineChartData(dataSet: lineDataSet)
        let data = CombinedChartData()
        data.lineData = lineChartData
        combinedChart.data = data
        lineDataSet.colors = [.blue]
        lineDataSet.lineWidth = 1.5
        lineDataSet.setCircleColor(.blue)
    }
    
    func configureChart(_ combinedChart: CombinedChartView) {
        combinedChart.noDataText = "No Data"
        combinedChart.drawValueAboveBarEnabled = false
        combinedChart.setScaleEnabled(false)
        combinedChart.animate(xAxisDuration: 0.5, yAxisDuration: 0.5, easingOption: .easeInOutBounce)
        if combinedChart.scaleX == 1.0 && quarter == 0 {
            combinedChart.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        } else {
            combinedChart.fitScreen()
        }
        let marker: CombinedMarker = CombinedMarker(color: UIColor.white,
                                                    font: UIFont(name: "Helvetica", size: 14)!,
                                                    textColor: UIColor.black,
                                                    insets: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                                                    quarter: quarter)
        marker.minimumSize = CGSize(width: 100, height: 50)
        combinedChart.marker = marker
    }
    
    func formatXAxis(_ xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = -0.5
        xAxis.axisMaximum = Double(lineEntries.count) + 2
        xAxis.granularity = 2
        xAxis.gridColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.5)
        xAxis.valueFormatter = IndexAxisValueFormatter(values: Sale.monthsToDisplayForQuarter(quarter))
        xAxis.labelTextColor =  UIColor.label
    }
    


}



struct CombinedChart_Previews: PreviewProvider {
    static var previews: some View {
        CombinedChart(lineEntries: Sale.TransactionsFor(Sale.allSales, quarter: 0), quarter: .constant(0))
    }
}
