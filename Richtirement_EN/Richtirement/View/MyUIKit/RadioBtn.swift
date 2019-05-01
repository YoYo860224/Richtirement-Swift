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

class SelectBtn: RadioBtn {
    override func initSelf() {
        super.initSelf()
        
        self.layer.backgroundColor = UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1.0).cgColor
        self.layer.cornerRadius = self.frame.height / 3
        if let sublabel = self.subviews[0] as? UILabel {
            sublabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }
    }
    
    @objc override func targetViewDidTapped(_ sender: Any) {
        if checkState {
            uncheck()
        }
        else {
            check()
        }
    }
    
    override func check() {
        // Using UIView.transition is more strong than animate.
        // But I has Fixed layerBG by using ainmate, that also a useful way.
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.backgroundColor = UIColor(red: 255/255, green: 216/255, blue: 113/255, alpha: 1.0).cgColor
        })
        
        if self.subviews.count > 0 {
            if let sublabel = self.subviews[0] as? UILabel {
                UIView.transition(with: sublabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    sublabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                }, completion: nil)
            }
        }
        checkState = true
    }
    
    override func uncheck() {
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.backgroundColor = UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1.0).cgColor
        })
        
        if self.subviews.count > 0 {
            if let sublabel = self.subviews[0] as? UILabel {
                UIView.transition(with: sublabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    sublabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                }, completion: nil)
            }
        }
        checkState = false
    }
}
