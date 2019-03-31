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
    
//    override func viewWillAppear(_ animated: Bool) {
//
//    }
    
    override func viewDidLoad() {
        setUI()
    }
    
    func setUI(){
        let p = SystemSetting.getPlayer()
        let gameover = p.isGameOver()
        gameOverResultView.alpha = 0
        if(gameover == 1){
            backgroundImageView.image = UIImage(named: "money0")
            gameoverResultTextView.text = "Money 0\nGameOver"
        }
        else if(gameover == 2){
            backgroundImageView.image = UIImage(named: "phychological0")
            gameoverResultTextView.text = "Phychological 0\nGameOver"

        }
        else if(gameover == 3){
            backgroundImageView.image = UIImage(named: "healthy0")
            gameoverResultTextView.text = "Healthy 0\nGameOver"

        }
        else if(gameover == 4){
            backgroundImageView.image = UIImage(named: "social0")
            gameoverResultTextView.text = "Social 0\nGameOver"

        }
    }
    
    
}

