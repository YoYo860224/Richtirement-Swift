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
        // let lCnH = NSLayoutConstraint(item: innerText, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 30)

        
        self.addSubview(innerText)
        innerText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tCnHor, tCnVer, lCnW])
    }
}
