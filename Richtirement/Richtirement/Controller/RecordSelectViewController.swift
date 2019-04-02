//
//  RecordSelectViewController.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/16.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit

class RecordSelectViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var createNewPlayerView: UIView!
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        for (_, v) in SystemSetting.BigPlayers {
            addPlayerBolck(player: v)
        }
        
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(newPlayer(_:)))
        gesture.numberOfTapsRequired = 1
        createNewPlayerView.isUserInteractionEnabled = true
        createNewPlayerView.addGestureRecognizer(gesture)
        createNewPlayerView.layer.cornerRadius = 3
    }

    func addPlayerBolck(player: BigPlayerData) {
        let pb = PlayerBlock(player: player)
        let cn1 = NSLayoutConstraint(item: pb, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 320)
        let cn2 = NSLayoutConstraint(item: pb, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 130)
        
        stackView.addArrangedSubview(pb)
        pb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([cn1, cn2])
        
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTapped(_:)))
        gesture.numberOfTapsRequired = 1
        pb.isUserInteractionEnabled = true
        pb.addGestureRecognizer(gesture)
    }
    
    @objc func newPlayer(_ sender: Any) {
        performSegue(withIdentifier: "goSet", sender: nil)
    }
    
    @objc func targetViewDidTapped(_ sender: Any) {
        let tg = sender as! UITapGestureRecognizer
        let pb = tg.view as! PlayerBlock
        SystemSetting.nowBigPlayerName = pb.playerName
        self.performSegue(withIdentifier: "tocpt", sender: nil)
    }
    
    @IBAction func unwindToSelect(_ unwindSegue: UIStoryboardSegue) {
        
    }
}

class PlayerBlock: UIView {
    var playerName = "沈政一"
    var blockImage = "PB01"
    
    var deleteOpen = false
    var deleteBtn: UIButton = UIButton()
    var oriTransform: CGAffineTransform = CGAffineTransform()
    
    init(player: BigPlayerData) {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 130))
        playerName = player.name
        blockImage = "RB"
        initSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSelf()
    }
    
    func initSelf() {
        self.backgroundColor = UIColor(red: 1, green: 216/255, blue: 113/255, alpha: 0)
        self.clipsToBounds = true
        
        let innerPic = UIImageView()
        innerPic.backgroundColor = UIColor.blue
        innerPic.image = UIImage(named: blockImage)
        innerPic.backgroundColor = UIColor(white: 57.0 / 255.0, alpha: 0)
        
        let imCnW = NSLayoutConstraint(item: innerPic, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0)
        let imCnH = NSLayoutConstraint(item: innerPic, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0)
        let imCnHor = NSLayoutConstraint(item: innerPic, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let imCnVer = NSLayoutConstraint(item: innerPic, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        self.addSubview(innerPic)
        innerPic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imCnHor, imCnVer, imCnW, imCnH])
        
        let innerText = UILabel()
        innerText.text = "玩家 " + playerName
        innerText.textColor = UIColor.white
        innerText.font = UIFont(name: "NotoSansCJKtc-Medium", size: 29)
        innerText.backgroundColor = UIColor(white: 57.0 / 255.0, alpha: 1)
        innerText.textAlignment = .center
        
        let tCnHor = NSLayoutConstraint(item: innerText, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let tCnVer = NSLayoutConstraint(item: innerText, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        let lCnW = NSLayoutConstraint(item: innerText, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: -30)

        self.addSubview(innerText)
        innerText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tCnHor, tCnVer, lCnW])
        
        // delebtn
        let deleteOutView = UIView()
        deleteOutView.backgroundColor = UIColor.clear
        deleteOutView.clipsToBounds = true
        
        let dvTo = NSLayoutConstraint(item: deleteOutView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 5)
        let dvBo = NSLayoutConstraint(item: deleteOutView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -5)
        let dvTr = NSLayoutConstraint(item: deleteOutView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -5)
        let dvXX = NSLayoutConstraint(item: deleteOutView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.7, constant: 0)
        
        self.addSubview(deleteOutView)
        deleteOutView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([dvTo, dvBo, dvTr, dvXX])
        
        deleteBtn = UIButton()
        deleteBtn.backgroundColor = UIColor(red: 1, green: 216/255, blue: 113/255, alpha: 1)
        deleteBtn.setTitle("刪除", for: .normal)
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
        SystemSetting.BigPlayers.removeValue(forKey: playerName)
        SystemSetting.save()
        self.removeFromSuperview()
    }
}
