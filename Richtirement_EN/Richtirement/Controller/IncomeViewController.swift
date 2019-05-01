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
    
    var allYear = 5
    var incomeVals: [Double] = []
    var outgoingVals: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setChart()
    }
    
    func setUI() {
        let p = SystemSetting.getPlayer()
        var incomeText = ""
        var outgoingText = ""
        incomeTextView.text = ""
        outgoingTextview.text = ""
        
        allYear = p.age - 55 + 1
        for _ in 55..<p.age {
            self.incomeVals.append(0)
            self.outgoingVals.append(0)
        }
        var annuityTotal = 0
        var expenseTotal = 0
        var stockTotal = 0
        var fundTotal = 0
        
        if(p.age > 65){
            for i in 0..<p.annuityRecord.count{
                if(p.annuityRecord.count - i <= 5){
                    annuityTotal += Int(p.annuityRecord[i])
                }
                self.incomeVals[i] += p.annuityRecord[i] / 10
            }
        }

        for i in 0..<p.livingExpenseRecord.count{
            if(p.livingExpenseRecord.count - i <= 5){
                expenseTotal += Int(p.livingExpenseRecord[i])
            }
            self.outgoingVals[i] += p.livingExpenseRecord[i] / 10
        }
        
        for i in 0 ..< p.stockRecord.count{
            if(p.stockRecord.count - i <= 5){
                stockTotal += Int(p.stockRecord[i])
            }
            if(p.stockRecord[i] > 0){
                self.incomeVals[i] += p.stockRecord[i] / 10
            }
            else{
                self.outgoingVals[i] -= p.stockRecord[i] / 10
            }
        }
        
        for i in 0 ..< p.fundRecord.count{
            if(p.fundRecord.count - i <= 5){
                fundTotal += Int(p.fundRecord[i])
            }
            if(p.fundRecord[i] > 0){
                self.incomeVals[i] += p.fundRecord[i] / 10
            }
            else{
                self.outgoingVals[i] -= p.fundRecord[i] / 10
            }
        }
        
        nthYearTextView.text = String(Int(p.age - 55)) + " year"
        allMoneyTextView.text =  String(Int(p.deposit + p.fund + p.stock + p.annuity + p.medicineInsurance) / 10) + "M"
        
        if(p.age > 65 && annuityTotal > 0){
            incomeText += "Annuity feedback " + String(annuityTotal / 10) + "M "
        }
        outgoingText = "Living " + String(expenseTotal / 10) + "M "
        if(fundTotal > 0){
            incomeText += "Fund " + String(fundTotal / 10) + "M "
        }
        else if(fundTotal < 0){
            outgoingText += "Fund " + String(-fundTotal / 10) + "M "
        }
        if(stockTotal > 0){
            incomeText += "Stocks " + String(stockTotal / 10) + "M "
        }
        else if(stockTotal < 0){
            outgoingText += "Stocks " + String(-stockTotal / 10) + "M "
        }
        
        incomeTextView.text = incomeText
        outgoingTextview.text = outgoingText
    }
    
    func setChart() {
        var inEntries: [ChartDataEntry] = []
        let nocence1 = ChartDataEntry(x: Double(1), y: incomeVals[0])
        inEntries.append(nocence1)
        for i in 1..<allYear {
            let dataEntry = ChartDataEntry(x: Double(i), y: incomeVals[i - 1])
            inEntries.append(dataEntry)
        }
        
        var outEntries: [ChartDataEntry] = []
        let nocence2 = ChartDataEntry(x: Double(1), y: outgoingVals[0])
        outEntries.append(nocence2)
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
        xAxis.avoidFirstLastClippingEnabled = false
        
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
        
        let xTitle = UILabel(frame: CGRect(x: 25, y: lineChartView.frame.height - 4, width: 40, height: 20))
        xTitle.text = "Year"
        xTitle.font = UIFont(name: "NotoSansCJKtc-Medium", size: 19)!
        xTitle.textColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        
        let yTitle = UILabel(frame: CGRect(x: 45, y: 0, width: 20, height: 20))
        yTitle.text = "M"
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
        lineChartView.setVisibleXRange(minXRange: 4.001, maxXRange: 4.001)
        lineChartView.moveViewToX(Double(1000))
    }
    
    @IBAction func confirmBtn_Click(_ sender: Any) {
        performSegue(withIdentifier: "toAsset", sender: nil)
    }
}

class IntVChartFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(Int(value))
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
