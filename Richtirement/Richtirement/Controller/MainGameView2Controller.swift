//
//  MainGameView2Controller.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/17.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit
import Foundation

class MainGameView2Controller: UIViewController {
    // TODO: - gameResultTitle 稍微注意一下 結果圖需要 title 嗎？ 不需要的話應該是 hidden 一下貨怎樣的
    // TODO: - gameResultText  垂直置中
    @IBOutlet weak var propM: PropImageView!
    @IBOutlet weak var propP: PropImageView!
    @IBOutlet weak var propH: PropImageView!
    @IBOutlet weak var propS: PropImageView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var quetionView: UIView!
    @IBOutlet weak var questionContent: UITextView!
    
    @IBOutlet weak var c1View: UIView!
    @IBOutlet weak var c1TextView: UILabel!
    @IBOutlet weak var c1ImageView: UIImageView!
    
    @IBOutlet weak var c2View: UIView!
    @IBOutlet weak var c2TextView: UILabel!
    @IBOutlet weak var c2ImageView: UIImageView!

    @IBOutlet weak var gameResultView: UIView!
    @IBOutlet weak var gameResultTexOuter: UIView!
    @IBOutlet weak var gameResultTitle: UILabel!
    @IBOutlet weak var gameResultText: UITextView!
    
    let s = Story.getStory()
    let p = SystemSetting.getPlayer()
    var nowQuestion: Question?
    var r: Result?
    
    var onChoice = 0

    var c1OriginalTransform:CGAffineTransform = CGAffineTransform()
    var c2OriginalTransform:CGAffineTransform = CGAffineTransform()
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        setStory()
        setUI()
    }
    
    func setStory() {
        propM.changeRatio(ratio: Double(p.money)         / 100.0, duration: 0)
        propP.changeRatio(ratio: Double(p.phychological) / 100.0, duration: 0)
        propH.changeRatio(ratio: Double(p.healthy)       / 100.0, duration: 0)
        propS.changeRatio(ratio: Double(p.social)        / 100.0, duration: 0)
        
        let nowEvent = s.events[p.nowEvent]!
        
        if nowEvent.absResult != nil {
            self.r = s.results[nowEvent.absResult!]
            
            gameResultTitle.text = ""
            gameResultText.text = r!.content
            
            for we in r!.willHappenedEvent {
                if(we != ""){
                    p.eventIDs.append(we)
                }
            }
            
            c1View.isHidden = true
            c2View.isHidden = true
            quetionView.isHidden = true
        }
        else {
            nowQuestion = s.questions[nowEvent.connectQuestion!]!
            let c1 = s.choices[nowQuestion!.choice1!]
            let c2 = s.choices[nowQuestion!.choice2!]
            
            imageView.image = nowEvent.img
            questionContent.text = nowQuestion!.content
            
            c1TextView.text = c1?.content
            c2TextView.text = c2?.content
            
            // Finish:- 卡片圖片可能要更改喔
            let c1ImageMainValue = c1?.getMainValue()
            if(c1ImageMainValue != "$"){
                c1ImageView.image = UIImage(named: "Card" + String(c1ImageMainValue!))
            }
            else{
                c1ImageView.image = UIImage(named: "CardM")
            }
            let c2ImageMainValue = c2?.getMainValue()
            if(c2ImageMainValue != "$"){
                c2ImageView.image = UIImage(named: "Card" + String(c2ImageMainValue!))
            }
            else{
                c2ImageView.image = UIImage(named: "CardM")
            }
            
            c1OriginalTransform = self.c1View.transform
            c2OriginalTransform = self.c2View.transform
        }
    }
    
    func setUI() {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.gameResultTexOuter.frame.size)
        gradient.colors = [
            UIColor(red: 255/255, green: 209/255, blue: 102/255, alpha: 1.0).cgColor,
            UIColor(red: 231/255, green:  98/255, blue: 122/255, alpha: 1.0).cgColor,
            UIColor(red:  63/255, green: 174/255, blue: 222/255, alpha: 1.0).cgColor,
            UIColor(red:  62/255, green: 195/255, blue: 160/255, alpha: 1.0).cgColor
        ]
        gradient.locations = [ 0.0, 0.37, 0.77, 1.0]
        
        let shape = CAShapeLayer()
        shape.lineWidth = 4
        shape.path = UIBezierPath(rect: self.gameResultTexOuter.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        self.gameResultTexOuter.layer.addSublayer(gradient)
    }
    
    @IBAction func c1_Click(_ sender: Any) {
        if(onChoice == 0 || onChoice == 2){
            if(onChoice == 2){
                UIView.animate(withDuration: 0.5, animations: {
                    self.c2View.transform = self.c2OriginalTransform
                })
            }
            let originalTransform = self.c1View.transform
            let scaledTransform = originalTransform.scaledBy(x: 1.2, y: 1.2)
            //        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: -250.0) move
            UIView.animate(withDuration: 0.5, animations: {
                self.c1View.transform = scaledTransform
            })
            onChoice = 1
        }
        else if (onChoice == 1){
            onChoice = 0

            let c1 = s.choices[nowQuestion!.choice1!]!
            
            if c1.nextQuestion != nil {
                UIView.animate(withDuration: 0.5, animations: {
                    self.c1View.transform = self.c1OriginalTransform
                    self.c2View.transform = self.c2OriginalTransform
                })


                nowQuestion = s.questions[c1.nextQuestion!]!
                let c_c1 = s.choices[nowQuestion!.choice1!]
                let c_c2 = s.choices[nowQuestion!.choice2!]
                
                questionContent.text = nowQuestion!.content
                
                c1TextView.text = c_c1?.content
                c2TextView.text = c_c2?.content
                
                // Finish:- 卡片圖片可能要更改喔
                let c1ImageMainValue = c_c1?.getMainValue()
                if(c1ImageMainValue != "$"){
                    c1ImageView.image = UIImage(named: "Card" + String(c1ImageMainValue!))
                }
                else{
                    c1ImageView.image = UIImage(named: "CardM")
                }
                let c2ImageMainValue = c_c2?.getMainValue()
                if(c2ImageMainValue != "$"){
                    c2ImageView.image = UIImage(named: "Card" + String(c2ImageMainValue!))
                }
                else{
                    c2ImageView.image = UIImage(named: "CardM")
                }
            }
            else {
                let rStr = c1.connectResult[0]!
                self.r = s.results[rStr]!
                imageView.image = r!.img
                gameResultTitle.text = ""
                gameResultText.text = r!.content
                
                for we in r!.willHappenedEvent {
                    if(we != ""){
                        p.eventIDs.append(we)
                    }
                }
                
                c1View.isHidden = true
                c2View.isHidden = true
                quetionView.isHidden = true
            }
        }
    }
    
    @IBAction func c2_Click(_ sender: Any) {
        if(onChoice == 0 || onChoice == 1){
            if(onChoice == 1){
                UIView.animate(withDuration: 0.5, animations: {
                    self.c1View.transform = self.c1OriginalTransform
                })
            }

            let originalTransform = self.c2View.transform
            let scaledTransform = originalTransform.scaledBy(x: 1.2, y: 1.2)
            UIView.animate(withDuration: 0.5, animations: {
                self.c2View.transform = scaledTransform
            })
            onChoice = 2
        }
        else if(onChoice == 2){
            onChoice = 0

            let c2 = s.choices[nowQuestion!.choice2!]!
            
            if c2.nextQuestion != nil {
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.c1View.transform = self.c1OriginalTransform
                    self.c2View.transform = self.c2OriginalTransform
                })
                nowQuestion = s.questions[c2.nextQuestion!]!
                let c_c1 = s.choices[nowQuestion!.choice1!]
                let c_c2 = s.choices[nowQuestion!.choice2!]
                
                questionContent.text = nowQuestion!.content
                
                c1TextView.text = c_c1?.content
                c2TextView.text = c_c2?.content
                
                // Finish:- 卡片圖片可能要更改喔
                let c1ImageMainValue = c_c1?.getMainValue()
                if(c1ImageMainValue != "$"){
                    c1ImageView.image = UIImage(named: "Card" + String(c1ImageMainValue!))
                }
                else{
                    c1ImageView.image = UIImage(named: "CardM")
                }
                let c2ImageMainValue = c_c2?.getMainValue()
                if(c2ImageMainValue != "$"){
                    c2ImageView.image = UIImage(named: "Card" + String(c2ImageMainValue!))
                }
                else{
                    c2ImageView.image = UIImage(named: "CardM")
                }
            }
            else {
                let rStr = c2.connectResult[0]!
                self.r = s.results[rStr]
                imageView.image = r!.img
                gameResultTitle.text = ""
                gameResultText.text = r!.content
                
                for we in r!.willHappenedEvent {
                    if(we != ""){
                        p.eventIDs.append(we)
                    }
                }
                
                c1View.isHidden = true
                c2View.isHidden = true
                quetionView.isHidden = true
            }
        }

    }
    
    @IBAction func imageView_Click(_ sender: Any) {
        // TODO:- 改變上面屬性圖片的 fill propX.changeRatio(0.4)
        // TODO:- 人物數值上的改變也要記得
        if quetionView.isHidden == true {
            valueChanged(change : (r?.valueChange)!)
            
            self.gameResultView.isHidden = false
            self.gameResultView.alpha = 0
            UIView.transition(with: gameResultView, duration: 0.5, options: .curveEaseInOut, animations: {
                self.gameResultView.alpha = 1
            }, completion: nil)
            
            
        }
    }
    
    func valueChanged(change: [String]){
        let p = SystemSetting.getPlayer()

        for i in change{
            let value = i.components(separatedBy: " ")
            var num = 0
            if(value.count == 3){
                num = Int(value[2])!
            }
            else if (value.count == 4){
                num = Int.random(in: Int(value[2])!...Int(value[3])!)
            }
            
            if(value[0] == "$"){
                if(value[1] == "+"){
                    p.deposit += num
                }
                else{
                    // TODO: 判斷破產
                    let _ = p.payMoney(money: num)
                }
                propM.changeRatio(ratio: Double(p.money) / 100.0, duration: 1)
            }
            else if(value[0] == "P"){
                if(value[1] == "+"){
                    p.phychological += num
                }
                else{
                    p.phychological -= num

                }
                propP.changeRatio(ratio: Double(p.phychological) / 100.0, duration: 1)

            }
            else if(value[0] == "H"){
                if(value[1] == "+"){
                    p.healthy += num

                }
                else{
                    p.healthy -= num

                }
                propH.changeRatio(ratio: Double(p.healthy) / 100.0, duration: 1)

            }
            else if(value[0] == "S"){
                if(value[1] == "+"){
                    p.social += num

                }
                else{
                    p.social -= num

                }
                propS.changeRatio(ratio: Double(p.social) / 100.0, duration: 1)

            }
        }
        
    }
    
    @IBAction func gameResultView_Click(_ sender: Any) {
        let p = SystemSetting.getPlayer()
        let s = Story.getStory()
        let nowEvent = s.events[p.nowEvent]!
        p.age += nowEvent.year
        
        if(p.isGameOver() != 0){
            // TODO: 連接game over畫面
            print("Game Over")
            performSegue(withIdentifier: "analysis", sender: nil)
        }
        if(p.eventIDs.count <= 0){
            performSegue(withIdentifier: "analysis", sender: nil)
        }
        else if(p.age % 5 == 0){
            performSegue(withIdentifier: "Asset", sender: nil)
        }
        else{
            performSegue(withIdentifier: "nextQuetion", sender: nil)
        }

    }
}

class PropImageView: UIView {
    @IBInspectable var image: UIImage?
    var ratio: Double = 0.5
    let top: CALayer = CALayer()
    
    func initSelf() {
        let mask = UIImageView(frame: CGRect(x: 0, y: 0, width: 45  , height: 45))
        mask.image = image
        mask.contentMode = .scaleAspectFit
        self.layer.mask = mask.layer

        top.backgroundColor = UIColor(white: 147/255, alpha: 1.0).cgColor
        let ratioHeight = 45 * (1 - ratio)
        self.layer.addSublayer(top)
        top.anchorPoint = CGPoint(x: 0, y: 0)
        top.frame = CGRect(x: 0, y: 0, width: 45, height: ratioHeight)
        top.position = CGPoint(x: 0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        initSelf()
    }
    
    func changeRatio(ratio: Double, duration: Double) {
        self.ratio = ratio
        let ratioHeight = 45 * (1 - ratio)

        let anim1 = CABasicAnimation(keyPath: "bounds")

        CATransaction.disableActions()
        top.bounds = CGRect(x: 0, y: 0, width: 45, height: ratioHeight)
        anim1.duration = 3.0
        
        top.add(anim1, forKey: nil)
    }
}
