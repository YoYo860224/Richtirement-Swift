//
//  GameOverViewController.swift
//  Richtirement
//
//  Created by SZY on 2019/3/31.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit
import Foundation

class GameOverViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var gameoverResultTextView: UITextView!
    @IBOutlet weak var gameOverResultView: UIView!
    @IBOutlet weak var eventTextOuter: UIView!
    
//    override func viewWillAppear(_ animated: Bool) {
//
//    }
    
    override func viewDidLoad() {
        setUI()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundImageTap(tapGestureRecognizer:)))
        backgroundImageView.isUserInteractionEnabled = true
        backgroundImageView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(gameoverResultTextViewTap(tapGestureRecognizer:)))
        gameoverResultTextView.isUserInteractionEnabled = true
        gameoverResultTextView.addGestureRecognizer(tapGestureRecognizer1)
    }
    
    @objc func backgroundImageTap(tapGestureRecognizer: UITapGestureRecognizer)
    {
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
//        if(tappedImage == backgroundImageView){
        gameOverResultView.isHidden = false
        UIView.transition(with: gameOverResultView, duration: 0.5, options: .curveEaseInOut, animations: {
            self.gameOverResultView.alpha = 1
        }, completion: nil)
//        }
    }
    
    @objc func gameoverResultTextViewTap(tapGestureRecognizer: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "analysis", sender: nil)

    }
    func setUI(){
        
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
        
        let p = SystemSetting.getPlayer()
        let gameover = p.isGameOver()
        gameOverResultView.alpha = 0
        gameOverResultView.isHidden = true
        

        if(gameover == 1){
            backgroundImageView.image = UIImage(named: "money0")
            gameoverResultTextView.text = "資產值歸0\nGameOver"
        }
        else if(gameover == 2){
            backgroundImageView.image = UIImage(named: "phychological0")
            gameoverResultTextView.text = "心理值歸0\nGameOver"

        }
        else if(gameover == 3){
            backgroundImageView.image = UIImage(named: "healthy0")
            gameoverResultTextView.text = "健康值歸0\nGameOver"

        }
        else if(gameover == 4){
            backgroundImageView.image = UIImage(named: "social0")
            gameoverResultTextView.text = "社交值歸0\nGameOver"
        }
        
        var topCorrection = (gameoverResultTextView.bounds.size.height - gameoverResultTextView.contentSize.height * 1) / 2.0
        topCorrection = max(0, topCorrection)
        gameoverResultTextView.contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
        
    }
    
    
}

