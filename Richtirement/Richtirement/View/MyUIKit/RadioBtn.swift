//
//  RadioBtn.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/12.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit

class RadioBtn: UIView {
    var checkState = false
    var checkGroup: [RadioBtn] = []
    
    func initSelf() {
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTapped(_:)))
        gesture.numberOfTapsRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = UIColor.clear
        self.layer.backgroundColor = UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1.0).cgColor
    }
    
    @objc func targetViewDidTapped(_ sender: Any) {
        check()
        for i in checkGroup {
            i.uncheck()
        }
    }
    
    func check() {
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.backgroundColor = UIColor(red: 255/255, green: 216/255, blue: 113/255, alpha: 1.0).cgColor
        })
        checkState = true
    }
    
    func uncheck() {
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.backgroundColor = UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1.0).cgColor
        })
        checkState = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSelf()
    }
}
