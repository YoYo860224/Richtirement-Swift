//
//  IncomeViewController.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/26.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit
import Charts

class IncomeViewController: UIViewController {
    @IBOutlet weak var lineChartView: LineChartView!
    
    let year = 5
    let incomeVals: [Double] = [0, 50, 22, 29]
    let outgoingVals: [Double] = [18, 22, 19, 23]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChart()
    }
    
    func setChart() {
        var inEntries: [ChartDataEntry] = []
        for i in 1..<year {
            let dataEntry = ChartDataEntry(x: Double(i), y: incomeVals[i - 1])
            inEntries.append(dataEntry)
        }
        
        var outEntries: [ChartDataEntry] = []
        for i in 1..<year {
            let dataEntry = ChartDataEntry(x: Double(i), y: outgoingVals[i - 1])
            outEntries.append(dataEntry)
        }
        
        let inDSet = LineChartDataSet(values: inEntries, label: "收入")
        inDSet.colors = [ NSUIColor(red: 255/255, green: 216/255, blue: 113/255, alpha: 1) ]
        inDSet.fillColor = UIColor(red: 255/255, green: 216/255, blue: 113/255, alpha: 1)
        inDSet.fillAlpha = 1
        inDSet.drawFilledEnabled = true
        inDSet.drawCirclesEnabled = false
        
        let outDSet = LineChartDataSet(values: outEntries, label: "支出")
        outDSet.colors = [ NSUIColor(red: 255/255, green: 96/255, blue: 96/255, alpha: 1) ]
        outDSet.fillColor = UIColor(red: 255/255, green: 96/255, blue: 96/255, alpha: 1)
        outDSet.fillAlpha = 0.7
        outDSet.drawFilledEnabled = true
        outDSet.drawCirclesEnabled = false
        
        let data = LineChartData()
        data.addDataSet(inDSet)
        data.addDataSet(outDSet)
        lineChartView.data = data

        lineChartView.chartDescription?.text = ""
        lineChartView.noDataText = "Loading Data"
        lineChartView.backgroundColor = UIColor.clear
        
        lineChartView.drawGridBackgroundEnabled = false
        
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = true
        
        lineChartView.dragEnabled = true
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.pinchZoomEnabled = true
        lineChartView.highlightPerTapEnabled = false
        lineChartView.highlightPerDragEnabled = false
        
        let xAxis = lineChartView.xAxis
        xAxis.enabled = true
        xAxis.labelPosition = .bottom
        xAxis.labelFont = UIFont(name: "NotoSansCJKtc-Medium", size: 19)!
        xAxis.labelTextColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        xAxis.gridColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        xAxis.drawGridLinesEnabled = true
        xAxis.valueFormatter = IntChartFormatter()
        
        let leftAxis = lineChartView.leftAxis
        leftAxis.enabled = true
        leftAxis.spaceTop = 1
        leftAxis.labelFont = UIFont(name: "NotoSansCJKtc-Medium", size: 19)!
        leftAxis.labelTextColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        leftAxis.gridColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        leftAxis.drawGridLinesEnabled = true
        leftAxis.axisMinimum = 0
        
        let legend = lineChartView.legend
        legend.enabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
}

class IntChartFormatter: NSObject, IAxisValueFormatter {
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if Double(Int(value)) == value {
            return String(Int(value))
        }
    
        return ""
    }
}
