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
    var chapterName = "章節 1"
    var blockImage: UIImage = UIImage(named: "PB01")!
    var isOver = false
    
    init(player: PlayerData) {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 130))
        
        bigIndex = player.bigIndex
        if player.resultTitle == "" {
            let c = (player.age - 55) / 5 + 1
            chapterName = "章節 " + String(c)
            isOver = false
            
            let s = Story.getStory()
            blockImage = (s.events[player.nowEvent]?.img)!
        }
        else {
            isOver = true
            chapterName = player.resultTitle

            
            if chapterName == "退休規劃達人" {
                blockImage = UIImage(named: "life_colorful")!
            }
            else if chapterName == "心靈富足者" {
                blockImage = UIImage(named: "life_vigorous")!
            }
            else if chapterName == "退休養生專家"{
                blockImage = UIImage(named: "life_happy")!
            }
            else if chapterName == "人見人愛活躍者" {
                blockImage = UIImage(named: "life_balance")!
            }
            else if chapterName == "急需策略者" {
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
    }
}
