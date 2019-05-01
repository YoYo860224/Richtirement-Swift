//
//  PersonalChapterViewController.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/17.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit

class PersonalChapterViewController: UIViewController {
    // TODO: 交給你了
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        for (_, v) in (SystemSetting.BigPlayers[SystemSetting.nowBigPlayerName]?.Players)! {
            addRecordBolck(player: v)
        }
    }
    
    func addRecordBolck(player: PlayerData) {
        let rb = RecordBlock(player: player)
        let cn1 = NSLayoutConstraint(item: rb, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 320)
        let cn2 = NSLayoutConstraint(item: rb, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 130)
        
        stackView.addArrangedSubview(rb)
        rb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([cn1, cn2])
        
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTapped(_:)))
        gesture.numberOfTapsRequired = 1
        rb.isUserInteractionEnabled = true
        rb.addGestureRecognizer(gesture)
        
        if rb.isOver == true {
            let anaBtn = UIButton()
            anaBtn.setImage(UIImage(named: "CHAnalyze"), for: .normal)
            let bcn1 = NSLayoutConstraint(item: anaBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 275)
            let bcn2 = NSLayoutConstraint(item: anaBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 42.5)
            stackView.addArrangedSubview(anaBtn)
            anaBtn.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([bcn1, bcn2])
            anaBtn.addTarget(self, action: #selector(seeAna(_:)), for: .touchUpInside)
            anaBtn.tag = rb.bigIndex
        }
    }
    
    @objc func seeAna(_ sender: Any) {
        let btn = sender as! UIButton
        SystemSetting.nowBigID = btn.tag
        self.performSegue(withIdentifier: "toAna", sender: nil)
    }
    
    @objc func targetViewDidTapped(_ sender: Any) {
        let tg = sender as! UITapGestureRecognizer
        let rb = tg.view as! RecordBlock
        if rb.isOver == false {
            SystemSetting.nowBigID = rb.bigIndex
            self.performSegue(withIdentifier: "toGame", sender: nil)
        }
    }
    
    @IBAction func newChapter_Tap(_ sender: Any) {
        let bigPlayer = SystemSetting.getBigPlayer()
        let player = PlayerData()
        player.name = bigPlayer.name
        player.deposit = bigPlayer.InitMoney
        player.InitMoney = bigPlayer.InitMoney
        player.bigIndex = bigPlayer.bigIndex
        
        SystemSetting.nowBigID = bigPlayer.bigIndex
        bigPlayer.Players[bigPlayer.bigIndex] = player
        bigPlayer.bigIndex += 1
        
        performSegue(withIdentifier: "toGame", sender: nil)
    }
}

class RecordBlock: UIView {
    var bigIndex = 0
    var chapterName = "Chapter 1"
    var blockImage: UIImage = UIImage(named: "PB01")!
    var isOver = false
    
    var deleteOpen = false
    var deleteBtn: UIButton = UIButton()
    var oriTransform: CGAffineTransform = CGAffineTransform()
    
    init(player: PlayerData) {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 130))
        
        bigIndex = player.bigIndex
        if player.resultTitle == "" {
            let c = (player.age - 55) / 5 + 1
            chapterName = "Chapter " + String(c)
            isOver = false
            
            let s = Story.getStory()
            let nowEvent = s.events[player.nowEvent] ?? s.events["E0"]!
            blockImage = (nowEvent.img)!
        }
        else {
            isOver = true
            chapterName = player.resultTitle

            if chapterName == "Colorful Life" {
                blockImage = UIImage(named: "life_colorful")!
            }
            else if chapterName == "Vigorous Life" {
                blockImage = UIImage(named: "life_vigorous")!
            }
            else if chapterName == "Happy Life"{
                blockImage = UIImage(named: "life_happy")!
            }
            else if chapterName == "Balance Life" {
                blockImage = UIImage(named: "life_balance")!
            }
            else if chapterName == "Nothing but money" {
                blockImage = UIImage(named: "life_nothing but money")!
            }
        }
    
        initSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSelf()
    }
    
    func initSelf() {
        self.backgroundColor = UIColor(red: 1, green: 216/255, blue: 113/255, alpha: 1)
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
        
        let innerPic = UIImageView()
        innerPic.backgroundColor = UIColor(white: 57.0 / 255.0, alpha: 0)
        innerPic.image = blockImage
        innerPic.contentMode = .scaleAspectFill
        innerPic.clipsToBounds = true
        innerPic.layer.cornerRadius = 3
        
        let imCnW = NSLayoutConstraint(item: innerPic, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: -7)
        let imCnH = NSLayoutConstraint(item: innerPic, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: -7)
        let imCnHor = NSLayoutConstraint(item: innerPic, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let imCnVer = NSLayoutConstraint(item: innerPic, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        self.addSubview(innerPic)
        innerPic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imCnHor, imCnVer, imCnW, imCnH])
        
        let innerText = UILabel()
        innerText.text = chapterName
        innerText.textColor = UIColor.white
        innerText.textAlignment = .center
        innerText.font = UIFont(name: "NotoSansCJKtc-Medium", size: 29)
        innerText.clipsToBounds = true
        innerText.layer.cornerRadius = 3
        innerText.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        let tCnW = NSLayoutConstraint(item: innerText, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: -7)
        let tCnH = NSLayoutConstraint(item: innerText, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: -7)
        let tCnHor = NSLayoutConstraint(item: innerText, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let tCnVer = NSLayoutConstraint(item: innerText, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        self.addSubview(innerText)
        innerText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tCnW, tCnH, tCnHor, tCnVer])
        
        // delebtn
        let deleteOutView = UIView()
        deleteOutView.backgroundColor = UIColor.clear
        deleteOutView.clipsToBounds = true
        
        let dvTo = NSLayoutConstraint(item: deleteOutView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let dvBo = NSLayoutConstraint(item: deleteOutView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        let dvTr = NSLayoutConstraint(item: deleteOutView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let dvXX = NSLayoutConstraint(item: deleteOutView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.7, constant: 0)
        
        self.addSubview(deleteOutView)
        deleteOutView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([dvTo, dvBo, dvTr, dvXX])
        
        deleteBtn = UIButton()
        deleteBtn.backgroundColor = UIColor(red: 1, green: 216/255, blue: 113/255, alpha: 1)
        deleteBtn.setTitle("del", for: .normal)
        deleteBtn.setTitleColor(UIColor.gray, for: .normal)
        deleteBtn.titleLabel?.font = UIFont(name: "NotoSansCJKtc-Medium", size: 29)
        deleteBtn.clipsToBounds = true
        
        let bTo = NSLayoutConstraint(item: deleteBtn, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let bBo = NSLayoutConstraint(item: deleteBtn, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        let bLe = NSLayoutConstraint(item: deleteBtn, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let bXX = NSLayoutConstraint(item: deleteBtn, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 2.3, constant: 0)
        
        deleteOutView.addSubview(deleteBtn)
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bTo, bBo, bLe, bXX])
        deleteBtn.addTarget(self, action: #selector(deleteBtn_Click(_:)), for: .touchUpInside)
        oriTransform = deleteBtn.transform
        deleteOpen = false
        
        let gesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(deShow(_:)))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func deShow(_ sender: Any) {
        let recognizer = sender as! UIPanGestureRecognizer
        let moveX = recognizer.translation(in: self).x
        
        if deleteOpen {
            if moveX < deleteBtn.frame.width && moveX > 0{
                let thisTransform = oriTransform.translatedBy(x: moveX, y: 0)
                deleteBtn.transform  = thisTransform
            }
            
            if recognizer.state == .ended {
                if moveX < deleteBtn.frame.width / 2 {
                    let thisTransform = oriTransform.translatedBy(x: 0, y: 0)
                    UIView.animate(
                        withDuration: 0.2,
                        delay: 0,
                        options: [],
                        animations: {
                            self.deleteBtn.transform  = thisTransform })
                }
                else {
                    deleteOpen = false
                    oriTransform = oriTransform.translatedBy(x: deleteBtn.frame.width, y: 0)
                    UIView.animate(
                        withDuration: 0.2,
                        delay: 0,
                        options: [],
                        animations: {
                            self.deleteBtn.transform  = self.oriTransform })
                }
            }
        }
        else {
            if -moveX < deleteBtn.frame.width {
                let thisTransform = oriTransform.translatedBy(x: moveX, y: 0)
                deleteBtn.transform  = thisTransform
            }
            
            if recognizer.state == .ended {
                if -moveX < deleteBtn.frame.width / 2 {
                    let thisTransform = oriTransform.translatedBy(x: 0, y: 0)
                    UIView.animate(
                        withDuration: 0.2,
                        delay: 0,
                        options: [],
                        animations: {
                            self.deleteBtn.transform  = thisTransform })
                }
                else {
                    deleteOpen = true
                    oriTransform = oriTransform.translatedBy(x: -deleteBtn.frame.width, y: 0)
                    UIView.animate(
                        withDuration: 0.2,
                        delay: 0,
                        options: [],
                        animations: {
                            self.deleteBtn.transform  = self.oriTransform })
                }
            }
        }
    }
    
    @objc func deleteBtn_Click(_ sender: Any) {
        SystemSetting.BigPlayers[SystemSetting.nowBigPlayerName]?.Players.removeValue(forKey: bigIndex)
        SystemSetting.save()
        self.removeFromSuperview()
    }
}
