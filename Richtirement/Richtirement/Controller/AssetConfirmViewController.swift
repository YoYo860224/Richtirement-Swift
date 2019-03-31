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
    
    @IBOutlet weak var medicineInsuranceLabel: UILabel!
    
    var receivedDeposit: Int = 0
    var receivedStock: Int = 0
    var receivedFund: Int = 0
    var receivedAnnuity: Int = 0
    var receivedMedicineInsurance: Int = 0

    override func viewWillAppear(_ animated: Bool) {
        let p = SystemSetting.getPlayer()

        totalMoneyLabel.text = "總資產  " + String(receivedDeposit + receivedStock + receivedFund + receivedAnnuity + receivedMedicineInsurance + p.annuity + p.medicineInsurance) + "萬"
        
        depositLabel.text = String(receivedDeposit) + "萬"
        stockLabel.text = String(receivedStock) + "萬"
        fundLabel.text = String(receivedFund) + "萬"
        medicineInsuranceLabel.text = String(p.medicineInsurance + receivedMedicineInsurance) + "萬"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toBack" {
            
            let secondVC = segue.destination as! AssetViewController
            
            secondVC.receivedStock = receivedStock
            secondVC.receivedFund = receivedFund
            secondVC.receivedAnnuity = receivedAnnuity
            secondVC.receivedMedicineInsurance = receivedMedicineInsurance
            
            secondVC.receivedDeposit = receivedDeposit
        }
    }
    
    @IBAction func ConfirmBtn_Click(_ sender: UIButton) {
        let p = SystemSetting.getPlayer()
        
        p.stock = receivedStock
        p.fund = receivedFund
        p.annuity += receivedAnnuity
        p.medicineInsurance += receivedMedicineInsurance
        p.deposit = receivedDeposit
    }
    
}
