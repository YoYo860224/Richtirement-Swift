//
//  ViewController.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/4.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startBtn_Click(_ sender: Any) {
        // TODO:  如果使用者不是第一次用 換成 segue 到 record select
        
        // for Test
//        let bigPlayer = BigPlayerData()
//        bigPlayer.name = "Hi"
//        bigPlayer.gender = 1
//        bigPlayer.hasChilds = true
//        bigPlayer.hasParent = true
//        bigPlayer.hasCouple = true
//        bigPlayer.hasFriend = true
//        bigPlayer.InitMoney = 3000
//
//        SystemSetting.nowBigPlayerName = "Hi"
//        SystemSetting.BigPlayers["Hi"] = bigPlayer
//
//        let player = PlayerData()
//        player.name = "Hi"
//        player.age = 70
//        player.nowEvent = "E1"
//        player.deposit = 3000
//        player.InitMoney = 3000
//        player.bigIndex = bigPlayer.bigIndex
//
//        SystemSetting.nowBigID = bigPlayer.bigIndex
//        bigPlayer.Players[bigPlayer.bigIndex] = player
//        bigPlayer.bigIndex += 1
        
        if SystemSetting.BigPlayers.count == 0 {
            performSegue(withIdentifier: "first", sender: nil)
        }
        else {
            performSegue(withIdentifier: "normal", sender: nil)
        }
    }
}

