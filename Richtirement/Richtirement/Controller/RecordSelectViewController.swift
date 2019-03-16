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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPlayerBolck()
    }
    
    func addPlayerBolck() {
        let a = PlayerBlock(frame: CGRect(x: 0, y: 0, width: 320, height: 130))
        let cn1 = NSLayoutConstraint(item: a, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 320)
        let cn2 = NSLayoutConstraint(item: a, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 130)
        
        stackView.addArrangedSubview(a)
        a.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([cn1, cn2])
    }
}

class PlayerBlock: UIView {
    func initSelf() {
        self.backgroundColor = UIColor(red: 1, green: 216/255, blue: 113/255, alpha: 1)
        
        let innerPic = UIImageView()
        innerPic.backgroundColor = UIColor.blue
        innerPic.image = UIImage(named: "PB01")
        
        // 幹 我原本以為黃色框框要自己編 所以把 Image 包在裡面
        let imCnW = NSLayoutConstraint(item: innerPic, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0)
        let imCnH = NSLayoutConstraint(item: innerPic, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0)
        let imCnHor = NSLayoutConstraint(item: innerPic, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let imCnVer = NSLayoutConstraint(item: innerPic, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        self.addSubview(innerPic)
        innerPic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imCnHor, imCnVer, imCnW, imCnH])
        
        let innerText = UILabel()
        innerText.text = "玩家 沈政一"
        innerText.textColor = UIColor.white
        innerText.font = UIFont(name: "NotoSansCJKtc-Medium", size: 29)
        
        let tCnHor = NSLayoutConstraint(item: innerText, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let tCnVer = NSLayoutConstraint(item: innerText, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        self.addSubview(innerText)
        innerText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tCnHor, tCnVer])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSelf()
    }
}