//
//  MainGameViewController.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/16.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit

class MainGameView1Controller: UIViewController {
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    @IBOutlet weak var eventTextView: UIView!
    @IBOutlet weak var eventTextOuter: UIView!
    @IBOutlet weak var eventText: UITextView!
    
    var nowEventContent: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStory()
        setUI()
    }
    
    func setStory() {
        let s = Story.getStory()
        let p = SystemSetting.getPlayer()
        
        p.getNextEvent()
        let nowEvent = s.events[p.nowEvent]!
        eventImageView.image = nowEvent.img
        if nowEvent.content == "" {
            nowEventContent = false
        }
        else {
            eventText.text = nowEvent.content
        }
    }
    
    func setUI() {
        // Color Outer
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.eventTextOuter.frame.size)
        gradient.colors = [
            UIColor(red: 255/255, green: 209/255, blue: 102/255, alpha: 1.0).cgColor,
            UIColor(red: 231/255, green:  98/255, blue: 122/255, alpha: 1.0).cgColor,
            UIColor(red:  63/255, green: 174/255, blue: 222/255, alpha: 1.0).cgColor,
            UIColor(red:  62/255, green: 195/255, blue: 160/255, alpha: 1.0).cgColor
        ]
        gradient.locations = [ 0.0, 0.37, 0.77, 1.0]
        
        let shape = CAShapeLayer()
        shape.lineWidth = 4
        shape.path = UIBezierPath(rect: self.eventTextOuter.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        self.eventTextOuter.layer.addSublayer(gradient)
        
        // Vertical align
        var topCorrection = (eventText.bounds.size.height - eventText.contentSize.height * 1) / 2.0
        topCorrection = max(0, topCorrection)
        eventText.contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
    }
    
    @IBAction func TapToNext(_ sender: Any) {
        if eventTextView.isHidden == true && nowEventContent{
            self.eventTextView.isHidden = false
            self.eventTextView.alpha = 0
            UIView.transition(with: eventTextView, duration: 0.5, options: .curveEaseInOut, animations: {
                
                self.eventTextView.alpha = 1
            }, completion: nil)
        }
        else {
            performSegue(withIdentifier: "toQuestion", sender: nil)
        }
    }
}
