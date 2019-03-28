//
//  AssetViewController.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/27.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit

class AssetViewController: UIViewController {
    // Finish: 交給你了 我只用灰階背景
    // TODO: 保險還沒做
    @IBOutlet weak var topBGView: UIView!
    
    @IBOutlet weak var assetPersent: UILabel!
    @IBOutlet weak var insurancePersent: UILabel!
    @IBOutlet weak var investPersent: UILabel!
    
    @IBOutlet weak var totalMoneyLabel: UILabel!
    
    @IBOutlet weak var depositUISlider: UISlider!
    @IBOutlet weak var stockUISlider: UISlider!
    @IBOutlet weak var fundUISlider: UISlider!
    
    @IBOutlet weak var depositLabel: UILabel!
    @IBOutlet weak var depositPersent: UILabel!
    
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var stockPersent: UILabel!
    
    @IBOutlet weak var fundLabel: UILabel!
    @IBOutlet weak var fundPersent: UILabel!
    
    var tempTotalMoney = 0
    var tempDeposit = 0
    var tempStock = 0
    var tempFund = 0
    
    @IBAction func stockUISlider(_ sender: UISlider) {
        sliderValueChanged(index: 0)
    }
    @IBAction func fundUISlider(_ sender: UISlider) {
        sliderValueChanged(index: 1)
    }
    
    func sliderValueChanged(index: Int){
        if(index == 0){
            depositUISlider.value = 1.0 - stockUISlider.value - fundUISlider.value

            if(depositUISlider.value <= 0){
                stockUISlider.value = 1.0 - fundUISlider.value
            }
            
            tempStock = Int(Float(tempTotalMoney) * Float(stockUISlider.value))

        }
        else if (index == 1){
            depositUISlider.value = 1.0 - stockUISlider.value - fundUISlider.value
            if(depositUISlider.value <= 0){
                fundUISlider.value = 1.0 - stockUISlider.value
            }
            tempFund = Int(Float(tempTotalMoney) * Float(fundUISlider.value))

        }
        
        depositUISlider.value = 1.0 - stockUISlider.value - fundUISlider.value
        tempDeposit = Int(Float(tempTotalMoney) - Float(tempFund) - Float(tempStock))
        
        assetPersent.text = String(Int(depositUISlider.value * 100)) + "%"
        insurancePersent.text = "0%"
        investPersent.text = String(Int((stockUISlider.value + fundUISlider.value) * 100)) + "%"
        
        depositLabel.text = String(tempDeposit) + "萬"
        depositPersent.text = String(Int(depositUISlider.value * 100)) + "%"
        
        stockLabel.text = String(tempStock) + "萬"
        stockPersent.text = String(Int(stockUISlider.value * 100)) + "%"
        
        fundLabel.text = String(tempFund) + "萬"
        fundPersent.text = String(Int(fundUISlider.value * 100)) + "%"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMoney()
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
    
    func getMoney(){
        let p = SystemSetting.getPlayer()
        tempDeposit = p.deposit
        tempStock = p.stock
        tempFund = p.fund
        tempTotalMoney = tempDeposit + tempStock + tempFund
        
        totalMoneyLabel.text = "總資產  " + String(tempTotalMoney) + "萬"
        depositUISlider.value = Float(Float(tempDeposit) / Float(tempTotalMoney))
        stockUISlider.value = Float(Float(tempStock) / Float(tempTotalMoney))
        fundUISlider.value = Float(Float(tempFund) / Float(tempTotalMoney))
        
        assetPersent.text = String(Int(depositUISlider.value * 100)) + "%"
        insurancePersent.text = "0%"
        investPersent.text = String(Int((stockUISlider.value + fundUISlider.value) * 100)) + "%"

        depositLabel.text = String(tempDeposit) + "萬"
        depositPersent.text = String(Int(depositUISlider.value * 100)) + "%"
        
        stockLabel.text = String(tempStock) + "萬"
        stockPersent.text = String(Int(stockUISlider.value * 100)) + "%"
        
        fundLabel.text = String(tempFund) + "萬"
        fundPersent.text = String(Int(fundUISlider.value * 100)) + "%"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let p = SystemSetting.getPlayer()
        p.stock = Int(Float(stockUISlider.value) * Float(tempTotalMoney))
        p.fund = Int(Float(fundUISlider.value) * Float(tempTotalMoney))
        
        p.deposit = tempTotalMoney - p.stock - p.fund
    }
    
    @IBAction func ToConfirmBtn_Click(_ sender: UIButton) {
        
    }
    
    
}
