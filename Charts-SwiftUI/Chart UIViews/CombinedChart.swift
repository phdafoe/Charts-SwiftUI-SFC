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
    var average: Double
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
        formatLineChartDataSet(lineDataSet)
    }
    
    func configureChart(_ combinedChart: CombinedChartView) {
        combinedChart.legend.enabled = false
        combinedChart.drawValueAboveBarEnabled = false
        combinedChart.setScaleEnabled(false)
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
    
    func formatLineChartDataSet(_ lineDataSet: LineChartDataSet) {
        lineDataSet.colors = [.blue]
        lineDataSet.lineWidth = 2.5
        lineDataSet.setCircleColor(.blue)
        lineDataSet.axisDependency = .right
    }
    
    func formatXAxis(_ xAxis: XAxis) {
        xAxis.gridLineDashLengths = [2]
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = -0.5
        xAxis.axisMaximum = Double(lineEntries.count) + 0.5
        xAxis.valueFormatter = IndexAxisValueFormatter(values: Sale.monthsToDisplayForQuarter(quarter))
        xAxis.labelTextColor =  UIColor.label
        xAxis.drawAxisLineEnabled = false
        xAxis.granularity = 1
    }
    
    func formatLeftAxis(_ leftAxis: YAxis) {
        leftAxis.gridLineDashLengths = [2]
        leftAxis.drawAxisLineEnabled = false
        leftAxis.axisMinimum = 0.5
        leftAxis.axisMaximum = (lineEntries.map{$0.y}.max() ?? 0) + 10
        leftAxis.labelTextColor =  .gray
        
        let ll1 = ChartLimitLine(limit: average, label: "\(average) €") // Promedio ojo con este valor
        ll1.lineWidth = 1
        ll1.lineDashLengths = [3]
        ll1.labelPosition = .topLeft
        ll1.valueFont = .systemFont(ofSize: 10)
        ll1.lineColor = .gray
        leftAxis.addLimitLine(ll1)
    }
    
    func formatRightAxis(_ rightAxis: YAxis) {
        rightAxis.enabled = false
    }



}



struct CombinedChart_Previews: PreviewProvider {
    static var previews: some View {
        CombinedChart(lineEntries: Sale.TransactionsFor(Sale.allSales, quarter: 0), average: 70, quarter: .constant(0))
    }
}
