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
    @IBOutlet weak var annuityUISlider: UISlider!
    @IBOutlet weak var medicineInsuranceUISlider: UISlider!
    
    @IBOutlet weak var depositLabel: UILabel!
    @IBOutlet weak var depositPersent: UILabel!
    
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var stockPersent: UILabel!
    
    @IBOutlet weak var fundLabel: UILabel!
    @IBOutlet weak var fundPersent: UILabel!
    
    @IBOutlet weak var annuityLabel: UILabel!
    @IBOutlet weak var annuityPersent: UILabel!

    @IBOutlet weak var medicineLabel: UILabel!
    @IBOutlet weak var medicinePersent: UILabel!
    
    @IBOutlet weak var annuityView: UIView!
    @IBOutlet weak var medicineView: UIView!
    
//    override func viewWillAppear(_ animated: Bool) {
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMoney()
        setUI()
    }
    
    func setUI() {
        let p = SystemSetting.getPlayer()
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.topBGView.frame.size)
        gradient.colors = [
            UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0).cgColor,
            UIColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 1.0).cgColor
        ]
        gradient.locations = [0.0, 1.0]
        topBGView.layer.insertSublayer(gradient, at: 0)
        
        if(p.age > 65){
            annuityView.isHidden = true
            medicineView.isHidden = true
        }
    }
    
    var tempTotalMoney = 0
    var tempDeposit = 0
    var tempStock = 0
    var tempFund = 0
    var tempAnnuity = 0
    var tempMedicineInsurance = 0
    
    var receivedDeposit: Int = 0
    var receivedStock: Int = 0
    var receivedFund: Int = 0
    var receivedAnnuity: Int = 0
    var receivedMedicineInsurance: Int = 0
    
    @IBAction func stockUISlider(_ sender: UISlider) {
        sliderValueChanged(index: 0)
    }
    @IBAction func fundUISlider(_ sender: UISlider) {
        sliderValueChanged(index: 1)
    }
    @IBAction func annuityUISlider(_ sender: UISlider) {
        sliderValueChanged(index: 2)
    }
    @IBAction func MedicineUISlider(_ sender: UISlider) {
        sliderValueChanged(index: 3)
    }
    
    func sliderValueChanged(index: Int){
        let p = SystemSetting.getPlayer()
        let stockSlideValue = Float(stockUISlider.value)
        let fundSlideValue = Float(fundUISlider.value)
        let annuitySlideValue = Float(annuityUISlider.value)
        let medicineInsuranceSlideValue = Float(medicineInsuranceUISlider.value)
        tempDeposit = Int(Float(tempTotalMoney) - stockSlideValue - fundSlideValue - annuitySlideValue - medicineInsuranceSlideValue)
        
        if(tempDeposit <= 0){
            if(index == 0){
                stockUISlider.value = Float(tempTotalMoney) - fundSlideValue - annuitySlideValue - medicineInsuranceSlideValue
            }
            else if (index == 1){
                fundUISlider.value = Float(tempTotalMoney) - stockSlideValue - annuitySlideValue - medicineInsuranceSlideValue
            }
            else if(index == 2){
                annuityUISlider.value = Float(tempTotalMoney) - stockSlideValue - fundSlideValue - medicineInsuranceSlideValue
            }
            else if(index == 3){
                medicineInsuranceUISlider.value = Float(tempTotalMoney) - stockSlideValue - fundSlideValue - annuitySlideValue
            }
        }
        tempStock = Int(stockUISlider.value)
        tempFund = Int(fundUISlider.value)
        tempAnnuity = Int(annuityUISlider.value)
        tempMedicineInsurance = Int(medicineInsuranceUISlider.value)

        tempDeposit = Int(Float(tempTotalMoney) - Float(tempFund) - Float(tempStock) - Float(tempAnnuity) - Float(tempMedicineInsurance))

        depositUISlider.value = Float(tempDeposit)
        
        assetPersent.text = String(Int(depositUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        insurancePersent.text = String(Int(Float(tempAnnuity + tempMedicineInsurance) / Float(tempTotalMoney) * 100)) + "%"
        investPersent.text = String(Int((stockUISlider.value + fundUISlider.value) / Float(tempTotalMoney) * 100)) + "%"
        
        depositLabel.text = String(tempDeposit / 10) + "M"
        depositPersent.text = String(Int(depositUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        
        stockLabel.text = String(tempStock / 10) + "M"
        stockPersent.text = String(Int(stockUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        
        fundLabel.text = String(tempFund / 10) + "M"
        fundPersent.text = String(Int(fundUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        
        annuityLabel.text = String(tempAnnuity / 10) + "M"
        annuityPersent.text = String(Int(annuityUISlider.value - Float(p.annuity))) + "%"
        
        medicineLabel.text = String(tempMedicineInsurance / 10) + "M"
        medicinePersent.text = String(Int(medicineInsuranceUISlider.value - Float(p.medicineInsurance))) + "%"
    }
    
    func getMoney(){
        let p = SystemSetting.getPlayer()
        
        if(receivedDeposit != 0){
            tempDeposit = receivedDeposit
        }
        else{
            tempDeposit = p.deposit
        }
        
        if(receivedStock != 0){
            tempStock = receivedStock
        }
        else{
            tempStock = p.stock
        }
        
        if(receivedFund != 0){
            tempFund = receivedFund
        }
        else{
            tempFund = p.fund
        }
        
        if(receivedAnnuity != p.annuity && receivedAnnuity != 0){
            tempAnnuity = receivedAnnuity
        }
        else{
            tempAnnuity = p.annuity
        }
        
        if(receivedMedicineInsurance != p.medicineInsurance && receivedMedicineInsurance != 0){
            tempMedicineInsurance = receivedMedicineInsurance
        }
        else{
            tempMedicineInsurance = p.medicineInsurance
        }
        
        tempTotalMoney = tempDeposit + tempStock + tempFund + tempAnnuity + tempMedicineInsurance

        depositUISlider.maximumValue = Float(tempTotalMoney)
        stockUISlider.maximumValue = Float(tempTotalMoney)
        fundUISlider.maximumValue = Float(tempTotalMoney)
        
        annuityUISlider.minimumValue = Float(p.annuity)
        medicineInsuranceUISlider.minimumValue = Float(p.medicineInsurance)
        annuityUISlider.maximumValue = Float(p.annuity) + 100
        medicineInsuranceUISlider.maximumValue = Float(p.medicineInsurance) + 100
        
        
        totalMoneyLabel.text = "Total assets  " + String(tempTotalMoney / 10) + "M"
        depositUISlider.value = Float(tempDeposit)
        stockUISlider.value = Float(tempStock)
        fundUISlider.value = Float(tempFund)
        annuityUISlider.value = Float(tempAnnuity)
        medicineInsuranceUISlider.value = Float(tempMedicineInsurance)

        assetPersent.text = String(Int(depositUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        insurancePersent.text = String(Int(Float(tempAnnuity + tempMedicineInsurance) / Float(tempTotalMoney) * 100)) + "%"
        investPersent.text = String(Int((stockUISlider.value + fundUISlider.value) / Float(tempTotalMoney) * 100)) + "%"
        
        depositLabel.text = String(tempDeposit / 10) + "M"
        depositPersent.text = String(Int(depositUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        
        stockLabel.text = String(tempStock / 10) + "M"
        stockPersent.text = String(Int(stockUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        
        fundLabel.text = String(tempFund / 10) + "M"
        fundPersent.text = String(Int(fundUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        
        annuityLabel.text = String(tempAnnuity / 10) + "M"
        annuityPersent.text = String(Int(annuityUISlider.value - Float(p.annuity))) + "%"
        
        medicineLabel.text = String(tempMedicineInsurance / 10) + "M"
        medicinePersent.text = String(Int(medicineInsuranceUISlider.value - Float(p.medicineInsurance))) + "%"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toConfirm" {
            let secondVC = segue.destination as! AssetConfirmViewController
            
            let stock = Int(Float(stockUISlider.value))
            let fund = Int(Float(fundUISlider.value))
            let annuity = Int(Float(annuityUISlider.value))
            let medicineInsurance = Int(Float(medicineInsuranceUISlider.value))
            
            secondVC.receivedStock = stock
            secondVC.receivedFund = fund
            secondVC.receivedAnnuity = annuity
            secondVC.receivedMedicineInsurance = medicineInsurance

            secondVC.receivedDeposit = tempTotalMoney - stock - fund - annuity - medicineInsurance
        }
    }
}
