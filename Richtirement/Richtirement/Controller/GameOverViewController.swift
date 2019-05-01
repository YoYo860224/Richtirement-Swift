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
        gameOverResultView.isHidden = false
        UIView.transition(with: gameOverResultView, duration: 0.5, options: .curveEaseInOut, animations: {
            self.gameOverResultView.alpha = 1
        }, completion: nil)
    }
    
    @objc func gameoverResultTextViewTap(tapGestureRecognizer: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "analysis", sender: nil)
    }
    
    func setUI(){
        let p = SystemSetting.getPlayer()
        let gameover = p.isGameOver()
        gameOverResultView.alpha = 0
        gameOverResultView.isHidden = true
        

        if(gameover == 1){
            backgroundImageView.image = UIImage(named: "money0")
            gameoverResultTextView.text = "資產值歸0\nGameOver"
            p.resultTitle = "money0"
        }
        else if(gameover == 2){
            backgroundImageView.image = UIImage(named: "phychological0")
            gameoverResultTextView.text = "心理值歸0\nGameOver"
            p.resultTitle = "phychological0"
        }
        else if(gameover == 3){
            backgroundImageView.image = UIImage(named: "healthy0")
            gameoverResultTextView.text = "健康值歸0\nGameOver"
            p.resultTitle = "healthy0"
        }
        else if(gameover == 4){
            backgroundImageView.image = UIImage(named: "social0")
            gameoverResultTextView.text = "社交值歸0\nGameOver"
            p.resultTitle = "social0"
        }
        
        // Vertical align
        var topCorrection = (gameoverResultTextView.bounds.size.height - gameoverResultTextView.contentSize.height * 1) / 2.0
        topCorrection = max(0, topCorrection)
        gameoverResultTextView.contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
        
        SystemSetting.save()
    }
}

