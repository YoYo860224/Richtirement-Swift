//
//  AssetConfirmViewController.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/27.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit

class AssetConfirmViewController: UIViewController {
    // TODO: 交給你了 我只用灰階背景
    @IBOutlet weak var topBGView: UIView!
    
    @IBOutlet weak var totalMoneyLabel: UILabel!
    
    @IBOutlet weak var depositLabel: UILabel!
    
    @IBOutlet weak var stockLabel: UILabel!
    
    @IBOutlet weak var fundLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        let p = SystemSetting.getPlayer()

        totalMoneyLabel.text = "總資產  " + String(p.deposit + p.stock + p.fund) + "萬"
        
        depositLabel.text = String(p.deposit) + "萬"
        stockLabel.text = String(p.stock) + "萬"
        fundLabel.text = String(p.fund) + "萬"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.topBGView.frame.size)
        gradient.colors = [
            UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0).cgColor,
            UIColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 1.0).cgColor
        ]
        gradient.locations = [0.0, 1.0]
        topBGView.layer.insertSublayer(gradient, at: 0)
    }
    
    @IBAction func ConfirmBtn_Click(_ sender: UIButton) {
    }
    
}
