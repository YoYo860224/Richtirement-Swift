//
//  AnalysisViewController.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/27.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit
import Charts

class AnalysisViewController: UIViewController {
    // TODO: - 好像沒有結果的文字呢
    @IBOutlet weak var wholeReportView: UIView!
    @IBOutlet weak var wholeYearInfoView: UIView!
    @IBOutlet weak var wholeRadarView: UIView!
    @IBOutlet weak var radarChartView: UIView!
    @IBOutlet var illImgViews: [UIImageView]!
    @IBOutlet var illTxtViews: [UILabel]!
    
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultTextLabel: UITextView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    var fiveBIGData = [80, 64, 78, 82, 77]
    
    @IBOutlet weak var monetPigImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setStory()
        setUI()
        setChart()
    }
    
    func setStory() {
        let p = SystemSetting.getPlayer()

        fiveBIGData[0] = p.age
        fiveBIGData[1] = min(max(p.social, 0), 100)
        fiveBIGData[2] = min(max(p.healthy,0), 100)
        fiveBIGData[3] = min(max(p.phychological,0), 100)
        fiveBIGData[4] = min(max(p.getMoneyPersent(), 0), 100)
        
        totalMoneyLabel.text = String(max(Int(p.deposit + p.fund + p.stock) / 10, 0)) + " Million"
        ageLabel.text = "Live to " + String(p.age) + " years old"
        
        let resultText = DetectEndResult()
        resultTextLabel.text = resultText
    }
    
    func setUI() {
        monetPigImageView.image = monetPigImageView.image?.withRenderingMode(.alwaysTemplate)
        monetPigImageView.tintColor = UIColor(red: 255/255, green: 216/255, blue: 113/255, alpha: 1)
    }

    func setChart() {
        radarChartView.backgroundColor = UIColor.clear
        
        let w = radarChartView.frame.width
        let h = radarChartView.frame.height
        let long = Double(w < h ? w / 2 * 0.6: h / 2 * 0.6)
        let midx = w / 2
        let midy = h / 2
        let midPoint = CGPoint(x: midx, y: midy)
        
        // x-Axis
        for i in 0...5 {
            //宣告Path與Layer
            let mLinePath = UIBezierPath()
            let mLineShapeLayer = CAShapeLayer()
            
            //設置起點與下一個點
            mLinePath.removeAllPoints()
            mLinePath.move(to: midPoint)
            mLinePath.addLine(to: pointCompute(ori: midPoint, radius: long, angle: -90 + 72 * Double(i)))
            
            //把path綁到Layer上，設置線的顏色跟寬度
            mLineShapeLayer.path = mLinePath.cgPath
            mLineShapeLayer.lineWidth = 1.0
            mLineShapeLayer.strokeColor = UIColor(red: 136.0 / 255.0,green: 136.0 / 255.0,blue: 136.0 / 255.0,alpha: 1).cgColor
            mLineShapeLayer.fillColor = UIColor.clear.cgColor
            
            radarChartView.layer.addSublayer(mLineShapeLayer)
        }
        
        // y-Axis
        for i in 0...5 {
            //宣告Path與Layer
            let mLinePath = UIBezierPath()
            let mLineShapeLayer = CAShapeLayer()
            
            //設置起點與下一個點
            mLinePath.removeAllPoints()
            mLinePath.move(to:    pointCompute(ori: midPoint, radius: long * Double(i) / 5.0, angle: -90))
            mLinePath.addLine(to: pointCompute(ori: midPoint, radius: long * Double(i) / 5.0, angle: -18))
            mLinePath.addLine(to: pointCompute(ori: midPoint, radius: long * Double(i) / 5.0, angle: 54))
            mLinePath.addLine(to: pointCompute(ori: midPoint, radius: long * Double(i) / 5.0, angle: 126))
            mLinePath.addLine(to: pointCompute(ori: midPoint, radius: long * Double(i) / 5.0, angle: 198))
            mLinePath.addLine(to: pointCompute(ori: midPoint, radius: long * Double(i) / 5.0, angle: -90))
            
            //把path綁到Layer上，設置線的顏色跟寬度
            mLineShapeLayer.path = mLinePath.cgPath
            mLineShapeLayer.lineWidth = 1.0
            mLineShapeLayer.strokeColor = UIColor(red: 136.0 / 255.0,green: 136.0 / 255.0,blue: 136.0 / 255.0,alpha: 1).cgColor
            mLineShapeLayer.fillColor = UIColor.clear.cgColor
            
            radarChartView.layer.addSublayer(mLineShapeLayer)
            
            // y label
            if i > 0 {
                let p1 = pointCompute(ori: midPoint, radius: long * Double(i) / 5.0, angle: -90)
                let p2 = pointCompute(ori: midPoint, radius: long * Double(i) / 5.0, angle: -18)
                
                let labelMiddle = CGPoint(
                    x: p1.x + (p2.x - p1.x) / CGFloat(2),
                    y: p1.y + (p2.y - p1.y) / CGFloat(2)
                )
                
                let labelWit: CGFloat = 20
                let labelHei: CGFloat = 13
                let yLabel = UILabel(frame: CGRect(x: labelMiddle.x - labelWit / 2,
                                                   y: labelMiddle.y - labelHei / 2,
                                                   width: labelWit,
                                                   height: labelHei))
                yLabel.text = String(i * 20)
                yLabel.font = UIFont(name: "NotoSansCJKtc-Medium", size: 11)
                yLabel.textColor = UIColor(red: 174.0 / 255.0,green: 174.0 / 255.0,blue: 174.0 / 255.0,alpha: 1)
                yLabel.textAlignment = .center
                radarChartView.addSubview(yLabel)
            }
        }
        
        // Plot data Fill
        let mLinePath = UIBezierPath()
        let mLineShapeLayer = CAShapeLayer()
        
        mLinePath.removeAllPoints()
        for (i, d) in fiveBIGData.enumerated() {
            if i == 0 {
                mLinePath.move(to: pointCompute(ori: midPoint, radius: long * Double(d) / 100.0, angle: -90))
            }
            else {
                mLinePath.addLine(to: pointCompute(ori: midPoint, radius: long * Double(d) / 100.0, angle: -90 + Double(i) * 72))
            }
        }
        mLinePath.addLine(to: pointCompute(ori: midPoint, radius: long * Double(fiveBIGData[0]) / 100.0, angle: -90))
        
        mLineShapeLayer.path = mLinePath.cgPath
        mLineShapeLayer.lineWidth = 2.0
        mLineShapeLayer.strokeColor = UIColor.clear.cgColor
        mLineShapeLayer.fillColor = UIColor(red: 96 / 255.0,green: 96 / 255.0,blue: 96 / 255.0,alpha: 0.6).cgColor

        radarChartView.layer.addSublayer(mLineShapeLayer)
        
        // Plot data Outer
        let colors: [CGColor] = [
            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor,
            UIColor(red:  62/255, green: 195/255, blue: 160/255, alpha: 1.0).cgColor,
            UIColor(red:  62/255, green: 174/255, blue: 222/255, alpha: 1.0).cgColor,
            UIColor(red: 234/255, green:  99/255, blue: 124/255, alpha: 1.0).cgColor,
            UIColor(red: 255/255, green: 209/255, blue: 102/255, alpha: 1.0).cgColor,
        ]
        
        for i in 0...4 {
            let otLinePath = UIBezierPath()
            let otLineShapeLayer = CAShapeLayer()
            
            otLinePath.removeAllPoints()
            let p1 = pointCompute(ori: midPoint, radius: long * Double(fiveBIGData[i]) / 100.0, angle: -90 + Double(i) * 72)
            let c1 = colors[i]
            var p2 = pointCompute(ori: midPoint, radius: long * Double(fiveBIGData[0]) / 100.0, angle: -90 + Double(0) * 72)
            var c2 = colors[0]
            if i != 4 {
                p2 = pointCompute(ori: midPoint, radius: long * Double(fiveBIGData[i + 1]) / 100.0, angle: -90 + Double(i + 1) * 72)
                c2 = colors[i + 1]
            }
            
            otLinePath.move(to: p1)
            otLinePath.addLine(to: p2)
            
            otLineShapeLayer.path = otLinePath.cgPath
            otLineShapeLayer.lineWidth = 2.0
            otLineShapeLayer.strokeColor = UIColor.black.cgColor
            otLineShapeLayer.fillColor = UIColor.clear.cgColor
    
            let gradient = CAGradientLayer()
            gradient.frame = CGRect(origin: CGPoint.zero, size: self.radarChartView.frame.size)
            let g1:NSNumber = NSNumber(value: Double(p1.y / h))
            let g2:NSNumber = NSNumber(value: Double(p2.y / h))
            gradient.colors = p1.y < p2.y ? [c1, c1, c2, c2] : [c2, c2, c1, c2]
            gradient.locations = p1.y < p2.y ? [0.0, g1, g2, 1.0] : [0.0, g2, g1, 1.0]
            gradient.mask = otLineShapeLayer

            radarChartView.layer.addSublayer(gradient)
            
            let pVal = pointCompute(ori: midPoint, radius: long * Double(fiveBIGData[i]) / 100.0 + 20, angle: -90 + Double(i) * 72)
            let labelWit: CGFloat = 45
            let labelHei: CGFloat = 25
            let valLabel = UILabel(frame: CGRect(x: pVal.x - labelWit / 2,
                                               y: pVal.y - labelHei / 2,
                                               width: labelWit,
                                               height: labelHei))
            valLabel.text = String(fiveBIGData[i])
            valLabel.font = UIFont(name: "NotoSansCJKtc-Medium", size: 24)
            valLabel.textColor = UIColor.white
            valLabel.textAlignment = .center
            radarChartView.addSubview(valLabel)
        }
        
        // plot Title1
        let titleLong = Double(w < h ? w / 2 * 0.8: h / 2 * 0.8)
        let pTitle1 = pointCompute(ori: midPoint, radius: titleLong, angle: -90)
        let title1Wit: CGFloat = 100
        let title1Hei: CGFloat = 100
        let title1Label = UILabel(frame: CGRect(
            x: pTitle1.x - title1Wit / 2,
            y: pTitle1.y - title1Hei / 2,
            width: title1Wit,
            height: title1Hei))
        title1Label.text = "Lifetime"
        title1Label.font = UIFont(name: "NotoSansCJKtc-Regular", size: 24)
        title1Label.textColor = UIColor.white
        title1Label.textAlignment = .center
        
        radarChartView.addSubview(title1Label)
        
        for i in 0..<4 {
            illImgViews[i].tintColor = UIColor(cgColor: colors[i + 1])
            illTxtViews[i].textColor = UIColor(cgColor: colors[i + 1])
            illTxtViews[i].textAlignment = .center
            illTxtViews[i].font = UIFont(name: "NotoSansCJKtc-Regular", size: 16)
        }
    }
    
    // MARK: - IBAction
    @IBAction func BackgroundImageView_Tap(_ sender: Any) {
        wholeYearInfoView.isHidden = false
        wholeReportView.isHidden = false
        wholeRadarView.isHidden = false
    }
    
    @IBAction func nextBtn_Click(_ sender: Any) {
        wholeRadarView.isHidden = true
    }
    
    @IBAction func confirmBtn_Click(_ sender: Any) {
        performSegue(withIdentifier: "restart", sender: nil)
    }
    
    @IBAction func showRadarBtn_Click(_ sender: Any) {
        wholeRadarView.isHidden = false
    }
    
    private func pointCompute(ori: CGPoint, radius: Double, angle: Double) -> CGPoint {
        let arc = angle * Double.pi / 180.0
        let x = ori.x + CGFloat(radius * cos(arc))
        let y = ori.y + CGFloat(radius * sin(arc))
        
        return CGPoint(x: x, y: y)
    }
    
    func DetectEndResult() -> String{
        let p = SystemSetting.getPlayer()
        let money = p.getMoneyPersent()
        let phychological = p.phychological
        let social = p.social
        let healthy = p.healthy
        
        var resultText = ""
        
        if(money > 50 && phychological > 50 && social > 50 && healthy > 50 &&
            money > phychological && money > social && money > healthy){
            backgroundImageView.image = UIImage(named: "life_colorful")
            resultTitleLabel.text = "Colorful Life"
            resultText += "Physiological, psychological and social values ​​are excellent, financial management is good, it is a colorful life!"
        }
        else if(phychological > 0 &&
            phychological > money && phychological > social && phychological > healthy){
            backgroundImageView.image = UIImage(named: "life_vigorous")
            resultTitleLabel.text = "Vigorous Life"
            resultText += "Psychological state is excellent, you does not have to live too rich, but to maintain a happy mood is the most important, right?"
        }
        else if(healthy > 0 &&
            healthy > money && healthy > social && healthy > phychological){
            backgroundImageView.image = UIImage(named: "life_happy")
            resultTitleLabel.text = "Happy Life"
            resultText += "Good health status! Life must be healthy to do more things."
        }
        else if(social > 0 &&
            social > money && social > healthy && social > phychological){
            backgroundImageView.image = UIImage(named: "life_balance")
            resultTitleLabel.text = "Balance Life"
            resultText += "Having a good social status, you have met many friends in the life, benefactors in the workplace, and even have a good relationship with the most important relatives."
        }
        else{
            backgroundImageView.image = UIImage(named: "life_nothing but money")
            resultTitleLabel.text = "Nothing but money"
            resultText += "Though you have enough living conditions and economic conditions, there is no good use and quality of life. Then, what is the meaning of living?"
        }
        p.resultTitle = resultTitleLabel.text!
        
        for text in p.resultRecord{
            if(text != ""){
                if(resultText != ""){
                    resultText += "\n\n"
                }
                resultText += text
            }
        }
        
        return resultText
    }
}
