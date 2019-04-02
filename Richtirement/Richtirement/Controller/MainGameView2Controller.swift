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
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var phychologicalLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var socialLabel: UILabel!
    
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
    @IBOutlet weak var gameResultTitle: UILabel!
    @IBOutlet weak var gameResultText: UITextView!
    
    let s = Story.getStory()
    let p = SystemSetting.getPlayer()
    var nowQuestion: Question?
    var r: Result?
    
    // 0: 沒選; 1: 選1; 2: 選2;
    var onChoice = 0

    var c1OriginalTransform: CGAffineTransform = CGAffineTransform()
    var c2OriginalTransform: CGAffineTransform = CGAffineTransform()
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        setStory()
        setUI()
    }
    
    func setStory() {
        // Set 4 prop
        propM.changeRatio(ratio: Double(p.getMoneyPersent()) / 100.0, duration: 0)
        propP.changeRatio(ratio: Double(p.phychological) / 100.0, duration: 0)
        propH.changeRatio(ratio: Double(p.healthy)       / 100.0, duration: 0)
        propS.changeRatio(ratio: Double(p.social)        / 100.0, duration: 0)
        
        let nowEvent = s.events[p.nowEvent]!
        imageView.image = nowEvent.img
        
        if nowEvent.absResult != nil {
            // 若為絕對事件
            c1View.isHidden = true
            c2View.isHidden = true
            quetionView.isHidden = true
            
            pBtn.isHidden = true
            UIView.animate(withDuration: 1.0,
                           delay: 0,
                           options: [],
                           animations: {
                            self.moneyLabel.alpha = 0
                            self.phychologicalLabel.alpha = 0
                            self.healthLabel.alpha = 0
                            self.socialLabel.alpha = 0
            }, completion: { (finished: Bool) in
                
                self.moneyLabel.text = " "
                self.phychologicalLabel.text = " "
                self.healthLabel.text = " "
                self.socialLabel.text = " "
                
                self.r = self.s.results[nowEvent.absResult!]
                
                self.gameResultTitle.text = ""
                self.gameResultText.text = self.r!.content
                
                self.p.eventIDs.remove(at: self.p.eventIDs.firstIndex(of: self.p.nowEvent)!)
                for we in self.r!.willHappenedEvent {
                    if(we != ""){
                        self.p.eventIDs.append(we)
                    }
                }
                
                self.valueChanged(change : (self.r?.valueChange)!)
            })
        }
        else {
            nowQuestion = s.questions[nowEvent.connectQuestion!]!
            setQuestion()
        }
    }
    
    func setUI() {
        // For card animate
        c1OriginalTransform = self.c1View.transform
        c2OriginalTransform = self.c2View.transform
    }
    
    func setQuestion() {
        let c1 = s.choices[nowQuestion!.choice1!]
        let c2 = s.choices[nowQuestion!.choice2!]
        
        questionContent.text = nowQuestion!.content
        c1TextView.text = c1?.content
        c2TextView.text = c2?.content
        
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
    }
    
    func valueChanged(change: [String]){
        let p = SystemSetting.getPlayer()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.moneyLabel.alpha = 1
            self.phychologicalLabel.alpha = 1
            self.healthLabel.alpha = 1
            self.socialLabel.alpha = 1
        })
        
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
                    self.moneyLabel.text = "+" + String(num)
                }
                else{
                    // TODO: 判斷破產
                    let _ = p.payMoney(money: num)
                    self.moneyLabel.text = "-" + String(num)
                }
                propM.changeRatio(ratio: Double(p.getMoneyPersent()) / 100.0, duration: 1)
                
                
                let originalTransform = self.propM.transform
                let scaledTransform = originalTransform.scaledBy(x: 1.3, y: 1.3)
                
                let labelOriginalTransform = self.moneyLabel.transform
                let labelScaledTransform = labelOriginalTransform.scaledBy(x: 1.3, y: 1.3)
                
                UIView.animate(withDuration: 0.3,
                               delay: 0,
                               options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat],
                               animations: {
                                UIView.setAnimationRepeatCount(4)
                                //                                self.propM.alpha = 0.5
                                self.propM.transform = scaledTransform
                                self.moneyLabel.transform = labelScaledTransform
                }, completion: { (finished: Bool) in
                    //                    self.propM.alpha = 1
                    //                    UIView.animate(withDuration: 0.2,animations:{
                    //                        self.propM.transform = scaledTransform
                    //                        self.moneyLabel.transform = labelScaledTransform
                    //                    })
                })
            }
            else if(value[0] == "P"){
                if(value[1] == "+"){
                    p.phychological += num
                    self.phychologicalLabel.text = "+" + String(num)
                }
                else{
                    p.phychological -= num
                    self.phychologicalLabel.text = "-" + String(num)
                }
                propP.changeRatio(ratio: Double(p.phychological) / 100.0, duration: 1)
                
                let originalTransform = self.propP.transform
                let scaledTransform = originalTransform.scaledBy(x: 1.3, y: 1.3)
                
                let labelOriginalTransform = self.phychologicalLabel.transform
                let labelScaledTransform = labelOriginalTransform.scaledBy(x: 1.3, y: 1.3)
                
                UIView.animate(withDuration: 0.3,
                               delay: 0,
                               options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat],
                               animations: {
                                UIView.setAnimationRepeatCount(4)
                                //                                self.propP.alpha = 0.5
                                self.propP.transform = scaledTransform
                                self.phychologicalLabel.transform = labelScaledTransform
                                
                }, completion: { (finished: Bool) in
                    //                    self.propP.alpha = 1
                    //                    UIView.animate(withDuration: 0.2,animations:{
                    //                        self.propP.transform = scaledTransform
                    //                        self.phychologicalLabel.transform = labelScaledTransform
                    //                    })
                })
            }
            else if(value[0] == "H"){
                if(value[1] == "+"){
                    p.healthy += num
                    self.healthLabel.text = "+" + String(num)
                }
                else{
                    p.healthy -= num
                    self.healthLabel.text = "-" + String(num)
                }
                propH.changeRatio(ratio: Double(p.healthy) / 100.0, duration: 1)
                let originalTransform = self.propH.transform
                let scaledTransform = originalTransform.scaledBy(x: 1.3, y: 1.3)
                
                let labelOriginalTransform = self.healthLabel.transform
                let labelScaledTransform = labelOriginalTransform.scaledBy(x: 1.3, y: 1.3)
                
                UIView.animate(withDuration: 0.3,
                               delay: 0,
                               options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat],
                               animations: {
                                UIView.setAnimationRepeatCount(4)
                                //                                self.propH.alpha = 0.5
                                self.propH.transform = scaledTransform
                                self.healthLabel.transform = labelScaledTransform
                                
                }, completion: { (finished: Bool) in
                    //                    self.propH.alpha = 1
                    //                    UIView.animate(withDuration: 0.2,animations:{
                    //                        self.propH.transform = scaledTransform
                    //                        self.healthLabel.transform = labelScaledTransform
                    //                    })
                })
            }
            else if(value[0] == "S"){
                if(value[1] == "+"){
                    p.social += num
                    self.socialLabel.text = "+" + String(num)
                }
                else{
                    p.social -= num
                    self.socialLabel.text = "-" + String(num)
                }
                propS.changeRatio(ratio: Double(p.social) / 100.0, duration: 1)
                let originalTransform = self.propS.transform
                let scaledTransform = originalTransform.scaledBy(x: 1.3, y: 1.3)
                
                let labelOriginalTransform = self.socialLabel.transform
                let labelScaledTransform = labelOriginalTransform.scaledBy(x: 1.3, y: 1.3)
                
                UIView.animate(withDuration: 0.3,
                               delay: 0,
                               options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat],
                               animations: {
                                UIView.setAnimationRepeatCount(4)
                                //                                self.propS.alpha = 0.5
                                self.propS.transform = scaledTransform
                                self.socialLabel.transform = labelScaledTransform
                                
                }, completion: { (finished: Bool) in
                    //                    self.propS.alpha = 1
                    //                    UIView.animate(withDuration: 0.2,animations:{
                    //                        self.propS.transform = scaledTransform
                    //                        self.socialLabel.transform = labelScaledTransform
                    //                    })
                })
            }
        }
        
    }
    
    // MARK: - IBAction
    @IBAction func c1_Click(_ sender: Any) {
        if(onChoice == 0 || onChoice == 2){
            if(onChoice == 2){
                // 選 2 把 c2 變回來
                UIView.animate(withDuration: 0.5, animations: {
                    self.c2View.transform = self.c2OriginalTransform
                })
            }
            
            // 1 放大
            let originalTransform = self.c1View.transform
            let scaledTransform = originalTransform.scaledBy(x: 1.2, y: 1.2)
            UIView.animate(withDuration: 0.5, animations: {
                self.c2View.alpha = 0.5
                self.c1View.transform = scaledTransform
                self.c1View.alpha = 1
            })
            onChoice = 1
        }
        else if (onChoice == 1){
            onChoice = 0

            let c1 = s.choices[nowQuestion!.choice1!]!
            if c1.nextQuestion != nil {
                // 還有下個問題
                UIView.animate(withDuration: 0.5, animations: {
                    self.c1View.transform = self.c1OriginalTransform
                    self.c2View.transform = self.c2OriginalTransform
                    self.c1View.alpha = 1
                    self.c2View.alpha = 1
                })

                nowQuestion = s.questions[c1.nextQuestion!]!
                setQuestion()
            }
            else {
                pBtn.isHidden = true
                UIView.animate(
                    withDuration: 1.0,
                    delay: 0,
                    options: [],
                    animations: {
                        self.c1View.alpha = 0
                        self.c2View.alpha = 0
                        self.quetionView.alpha = 0
                        
                        self.moneyLabel.alpha = 0
                        self.phychologicalLabel.alpha = 0
                        self.healthLabel.alpha = 0
                        self.socialLabel.alpha = 0
                        
                        self.imageView.alpha = 0},
                    completion: {
                        _ in
                        self.c1View.isHidden = true
                        self.c2View.isHidden = true
                        self.quetionView.isHidden = true
                        
                        self.moneyLabel.text = " "
                        self.phychologicalLabel.text = " "
                        self.healthLabel.text = " "
                        self.socialLabel.text = " "
                        
                        let rStr = c1.connectResult[0]!
                        self.r = self.s.results[rStr]!
                        if(self.r!.img != nil ){
                            self.imageView.image = self.r!.img
                        }
                        
                        UIView.animate(withDuration: 1.0, animations:{
                            self.imageView.alpha = 1
                        })
                        
                        self.gameResultTitle.text = ""
                        self.gameResultText.text = self.r!.content
                        
                        self.p.eventIDs.remove(at: self.p.eventIDs.firstIndex(of: self.p.nowEvent)!)
                        for we in self.r!.willHappenedEvent {
                            if(we != ""){
                                self.p.eventIDs.append(we)
                            }
                        }
                        self.valueChanged(change : (self.r?.valueChange)!)}
                )
            }
        }
    }
    
    @IBAction func c2_Click(_ sender: Any) {
        if(onChoice == 0 || onChoice == 1){
            if(onChoice == 1){
                // 選 1 把 c1 變回來
                UIView.animate(withDuration: 0.5, animations: {
                    self.c1View.transform = self.c1OriginalTransform
                })
            }
            
            // 2 放大
            let originalTransform = self.c2View.transform
            let scaledTransform = originalTransform.scaledBy(x: 1.2, y: 1.2)
            UIView.animate(withDuration: 0.5, animations: {
                self.c1View.alpha = 0.5
                self.c2View.transform = scaledTransform
                self.c2View.alpha = 1
            })
            onChoice = 2
        }
        else if(onChoice == 2){
            onChoice = 0

            let c2 = s.choices[nowQuestion!.choice2!]!
            if c2.nextQuestion != nil {
                // 還有下個問題
                UIView.animate(withDuration: 0.5, animations: {
                    self.c1View.transform = self.c1OriginalTransform
                    self.c2View.transform = self.c2OriginalTransform
                    self.c1View.alpha = 1
                    self.c2View.alpha = 1
                })
                
                nowQuestion = s.questions[c2.nextQuestion!]!
                setQuestion()
            }
            else {
                pBtn.isHidden = true
                UIView.animate(
                    withDuration: 1.0,
                    delay: 0,
                    options: [],
                    animations: {
                        self.c1View.alpha = 0
                        self.c2View.alpha = 0
                        self.quetionView.alpha = 0

                        self.moneyLabel.alpha = 0
                        self.phychologicalLabel.alpha = 0
                        self.healthLabel.alpha = 0
                        self.socialLabel.alpha = 0

                        self.imageView.alpha = 0},
                    completion: {
                        _ in
                        self.c1View.isHidden = true
                        self.c2View.isHidden = true
                        self.quetionView.isHidden = true
                        
                        self.moneyLabel.text = " "
                        self.phychologicalLabel.text = " "
                        self.healthLabel.text = " "
                        self.socialLabel.text = " "
                        
                        let rStr = c2.connectResult[0]!
                        self.r = self.s.results[rStr]
                        if(self.r!.img != nil){
                            self.imageView.image = self.r!.img
                        }
                        
                        UIView.animate(withDuration: 1.0, animations:{
                            self.imageView.alpha = 1
                        })
                        
                        self.gameResultTitle.text = ""
                        self.gameResultText.text = self.r!.content
                        
                        self.p.eventIDs.remove(at: self.p.eventIDs.firstIndex(of: self.p.nowEvent)!)
                        for we in self.r!.willHappenedEvent {
                            if(we != ""){
                                self.p.eventIDs.append(we)
                            }
                        }
                        self.valueChanged(change : (self.r?.valueChange)!)}
                )
            }
        }
    }
    
    @IBAction func imageView_Click(_ sender: Any) {
        if quetionView.isHidden == true {
            // Vertical align
            var topCorrection = (gameResultText.bounds.size.height - gameResultText.contentSize.height * 1) / 2.0
            topCorrection = max(0, topCorrection)
            gameResultText.contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
            
            self.gameResultView.alpha = 0
            self.gameResultView.isHidden = false

            UIView.transition(with: gameResultView, duration: 0.5, options: .curveEaseInOut, animations: {
                self.gameResultView.alpha = 1}, completion: nil)
            
            p.resultRecord.append(self.r?.endEffect ?? "")
            print(self.r?.endEffect as Any)
        }
    }
    
    @IBAction func gameResultView_Click(_ sender: Any) {
        let p = SystemSetting.getPlayer()
        let s = Story.getStory()
        let nowEvent = s.events[p.nowEvent]!
        
        for _ in 1...nowEvent.year {
            p.age += 1
            p.yearMoneyChange()
        }
        
        if(p.isGameOver() != 0){
            performSegue(withIdentifier: "gameover", sender: nil)
        }
        if(p.eventIDs.count <= 0){
            performSegue(withIdentifier: "analysis", sender: nil)
        }
        else if(p.age % 5 == 0){
            performSegue(withIdentifier: "Income", sender: nil)
        }
        else{
            performSegue(withIdentifier: "nextQuetion", sender: nil)
        }
    }
    
    // MARK: - 暫停功能區
    @IBOutlet weak var pauseMenu: UIView!
    @IBOutlet weak var pSettingBtn: UIButton!
    @IBOutlet weak var pBtn: UIButton!
    
    @IBAction func pauseBtn_Click(_ sender: Any) {
        pauseMenu.isHidden = false
        
        // 似乎沒什麼要設定的呢 就先關掉吧
        pSettingBtn.isHidden = true
    }
    
    @IBAction func pContinueBtn_Click(_ sender: Any) {
        pauseMenu.isHidden = true
    }
    
    @IBAction func pSettingBtn_Click(_ sender: Any) {
        // 似乎沒什麼要設定的呢 但還是放著吧
    }
    
    @IBAction func pGobackBtn_Click(_ sender: Any) {
        performSegue(withIdentifier: "backRecord", sender: nil)
    }
}

// MARK: - 4 屬性
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
