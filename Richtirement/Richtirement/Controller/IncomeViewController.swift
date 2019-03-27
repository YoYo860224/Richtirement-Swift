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
    @IBOutlet weak var incomeTextView: UILabel!
    @IBOutlet weak var outgoingTextview: UILabel!
    @IBOutlet weak var nthYearTextView: UILabel!
    @IBOutlet weak var allMoneyTextView: UILabel!
    
    let nowYear = 3
    let allYear = 9
    let incomeVals: [Double] = [0, 50, 22, 29, 12, 22, 33, 55, 11]
    let outgoingVals: [Double] = [18, 22, 19, 23, 22, 33, 55, 11, 33]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChart()
    }
    
    func setChart() {
        var inEntries: [ChartDataEntry] = []
        for i in 1..<allYear {
            let dataEntry = ChartDataEntry(x: Double(i), y: incomeVals[i - 1])
            inEntries.append(dataEntry)
        }
        
        var outEntries: [ChartDataEntry] = []
        for i in 1..<allYear {
            let dataEntry = ChartDataEntry(x: Double(i), y: outgoingVals[i - 1])
            outEntries.append(dataEntry)
        }
        
        let inDSet = LineChartDataSet(values: inEntries, label: "收入")
        inDSet.colors = [ NSUIColor(red: 255/255, green: 216/255, blue: 113/255, alpha: 1) ]
        inDSet.fillColor = UIColor(red: 255/255, green: 216/255, blue: 113/255, alpha: 1)
        inDSet.fillAlpha = 1
        inDSet.drawFilledEnabled = true
        inDSet.drawCirclesEnabled = false
        inDSet.valueFont = NSUIFont(name: "NotoSansCJKtc-Medium", size: 19)!
        inDSet.valueColors = [UIColor(red: 255/255, green: 216/255, blue: 113/255, alpha: 1)]
        inDSet.valueFormatter = IntVChartFormatter()
        
        let outDSet = LineChartDataSet(values: outEntries, label: "支出")
        outDSet.colors = [ NSUIColor(red: 255/255, green: 96/255, blue: 96/255, alpha: 1) ]
        outDSet.fillColor = UIColor(red: 255/255, green: 96/255, blue: 96/255, alpha: 1)
        outDSet.fillAlpha = 0.7
        outDSet.drawFilledEnabled = true
        outDSet.drawCirclesEnabled = false
        outDSet.valueFont = NSUIFont(name: "NotoSansCJKtc-Medium", size: 19)!
        outDSet.valueColors = [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)]
        outDSet.valueFormatter = IntVChartFormatter()
        
        let data = LineChartData()
        data.addDataSet(inDSet)
        data.addDataSet(outDSet)
        lineChartView.data = data

        lineChartView.chartDescription?.text = ""
        lineChartView.noDataText = "Loading Data"
        lineChartView.backgroundColor = UIColor.clear
        lineChartView.drawGridBackgroundEnabled = false

        let xAxis = lineChartView.xAxis
        xAxis.enabled = true
        xAxis.labelPosition = .bottom
        xAxis.labelFont = UIFont(name: "NotoSansCJKtc-Medium", size: 19)!
        xAxis.labelTextColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        xAxis.gridColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        xAxis.drawGridLinesEnabled = true
        xAxis.valueFormatter = IntAChartFormatter()
        xAxis.spaceMin = 0
        xAxis.granularity = 1
        xAxis.yOffset = 20
        
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = true
        let leftAxis = lineChartView.leftAxis
        leftAxis.enabled = true
        leftAxis.spaceTop = 1
        leftAxis.labelFont = UIFont(name: "NotoSansCJKtc-Medium", size: 19)!
        leftAxis.labelTextColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        leftAxis.gridColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        leftAxis.drawGridLinesEnabled = true
        leftAxis.valueFormatter = IntAChartFormatter()
        leftAxis.axisMinimum = 0
        leftAxis.xOffset = 30
        
        let legend = lineChartView.legend
        legend.enabled = false
        
        let xTitle = UILabel(frame: CGRect(x: 45, y: lineChartView.frame.height - 4, width: 20, height: 20))
        xTitle.text = "年"
        xTitle.font = UIFont(name: "NotoSansCJKtc-Medium", size: 19)!
        xTitle.textColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        
        let yTitle = UILabel(frame: CGRect(x: 45, y: 0, width: 20, height: 20))
        yTitle.text = "萬"
        yTitle.font = UIFont(name: "NotoSansCJKtc-Medium", size: 19)!
        yTitle.textColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        
        lineChartView.dragEnabled = true
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.highlightPerTapEnabled = false
        lineChartView.highlightPerDragEnabled = false
        
        lineChartView.addSubview(xTitle)
        lineChartView.addSubview(yTitle)
        lineChartView.extraTopOffset = 50
        lineChartView.setVisibleXRange(minXRange: 3.001, maxXRange: 3.001)
        lineChartView.moveViewToX(Double(nowYear) - 0.55 - 2)
    }
    
    @IBAction func confirmBtn_Click(_ sender: Any) {
        performSegue(withIdentifier: "toAsset", sender: nil)
    }
}

class IntVChartFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        if Double(Int(value)) == value {
            return String(Int(value))
            
        }
        return ""
    }
}


class IntAChartFormatter: NSObject, IAxisValueFormatter {
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if Double(Int(value)) == value {
            return String(Int(value))
            
        }
        return ""
    }
}
