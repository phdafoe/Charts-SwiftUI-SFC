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
        formatLeftAxis(uiView.leftAxis)
        formatRightAxis(uiView.rightAxis)
        uiView.notifyDataSetChanged()
    }
    
    func setChartData(_ combinedChart: CombinedChartView) {
        let lineDataSet = LineChartDataSet(entries: lineEntries)
        let lineChartData = LineChartData(dataSet: lineDataSet)
        let data = CombinedChartData()
        data.lineData = lineChartData
        combinedChart.data = data
        //combinedChart.chartDescription?.isEnabled = false
        lineDataSet.colors = [.blue]
        lineDataSet.lineWidth = 1.5
        lineDataSet.setCircleColor(.blue)
    }
    
    func configureChart(_ combinedChart: CombinedChartView) {
        //combinedChart.noDataText = "No Data"
        //combinedChart.descrription is enable -> OCulta el data set
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
        xAxis.gridLineDashLengths = [2]
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = -0.5
        xAxis.axisMaximum = Double(lineEntries.count) + 0.5
        xAxis.granularity = 2
        xAxis.valueFormatter = IndexAxisValueFormatter(values: Sale.monthsToDisplayForQuarter(quarter))
        xAxis.labelTextColor =  UIColor.label
        xAxis.drawAxisLineEnabled = false
    }
    
    func formatLeftAxis(_ leftAxis: YAxis) {
        leftAxis.gridLineDashLengths = [2]
        leftAxis.drawAxisLineEnabled = false
        leftAxis.axisMinimum = 0.5
        leftAxis.axisMaximum = (lineEntries.map{$0.y}.max() ?? 0) + 20
        leftAxis.labelTextColor =  .gray
    }
    
    func formatRightAxis(_ rightAxis: YAxis) {
        rightAxis.enabled = false
        rightAxis.drawAxisLineEnabled = false
    }



}



struct CombinedChart_Previews: PreviewProvider {
    static var previews: some View {
        CombinedChart(lineEntries: Sale.TransactionsFor(Sale.allSales, quarter: 0), quarter: .constant(0))
    }
}
