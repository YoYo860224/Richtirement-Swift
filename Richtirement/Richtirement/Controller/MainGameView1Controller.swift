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
            UIView.animate(withDuration: 1.0,
                           delay: 0,
                           options: [],
                           animations: {
                            self.eventTextView.alpha = 0
            }, completion: { (finished: Bool) in
                self.performSegue(withIdentifier: "toQuestion", sender: nil)
            })
        }
    }
}
