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

        if(index == 0){
            depositUISlider.value = 1.0 - stockUISlider.value - fundUISlider.value - ((Float(tempAnnuity) + Float(tempMedicineInsurance)) / Float(tempTotalMoney))

            if(depositUISlider.value <= 0){
                stockUISlider.value = 1.0 - fundUISlider.value - ((Float(tempAnnuity) + Float(tempMedicineInsurance)) / Float(tempTotalMoney))
            }
            
            tempStock = Int(Float(tempTotalMoney) * Float(stockUISlider.value))

        }
        else if (index == 1){
            depositUISlider.value = 1.0 - stockUISlider.value - fundUISlider.value - ((Float(tempAnnuity) + Float(tempMedicineInsurance)) / Float(tempTotalMoney))
            if(depositUISlider.value <= 0){
                fundUISlider.value = 1.0 - stockUISlider.value - ((Float(tempAnnuity) + Float(tempMedicineInsurance)) / Float(tempTotalMoney))
            }
            tempFund = Int(Float(tempTotalMoney) * Float(fundUISlider.value))
        }
        else if(index == 2){
            let annuitySlideValue = Float(annuityUISlider.value)
            let medicineInsuranceSlideValue = Float(medicineInsuranceUISlider.value)
            depositUISlider.value = 1.0 - stockUISlider.value - fundUISlider.value - (annuitySlideValue + medicineInsuranceSlideValue) / Float(tempTotalMoney)
            if(depositUISlider.value <= 0){
                tempAnnuity = tempTotalMoney - tempStock - tempFund - Int(medicineInsuranceUISlider.value)
                annuityUISlider.value = Float(tempAnnuity)
            }
            
            tempAnnuity = Int(annuityUISlider.value)
        }
        else if(index == 3){
            let annuitySlideValue = Float(annuityUISlider.value)
            let medicineInsuranceSlideValue = Float(medicineInsuranceUISlider.value)
            depositUISlider.value = 1.0 - stockUISlider.value - fundUISlider.value - (annuitySlideValue + medicineInsuranceSlideValue) / Float(tempTotalMoney)
            if(depositUISlider.value <= 0){
                tempMedicineInsurance = tempTotalMoney - tempStock - tempFund - Int(annuityUISlider.value)
                medicineInsuranceUISlider.value = Float(tempMedicineInsurance)
            }
            
            tempMedicineInsurance = Int(medicineInsuranceUISlider.value)
        }
        
        tempDeposit = Int(Float(tempTotalMoney) - Float(tempFund) - Float(tempStock) - Float(tempAnnuity) - Float(tempMedicineInsurance) - Float(p.annuity) - Float(p.medicineInsurance))
        depositUISlider.value = 1.0 - stockUISlider.value - fundUISlider.value - ((Float(tempAnnuity) + Float(tempMedicineInsurance) + Float(p.annuity) + Float(p.medicineInsurance)) / Float(tempTotalMoney))
        
        
        assetPersent.text = String(Int(depositUISlider.value * 100)) + "%"
        insurancePersent.text = String(Int(Float(p.annuity + p.medicineInsurance + tempAnnuity + tempMedicineInsurance) / Float(tempTotalMoney) * 100)) + "%"
        investPersent.text = String(Int((stockUISlider.value + fundUISlider.value) * 100)) + "%"
        
        depositLabel.text = String(tempDeposit) + "萬"
        depositPersent.text = String(Int(depositUISlider.value * 100)) + "%"
        
        stockLabel.text = String(tempStock) + "萬"
        stockPersent.text = String(Int(stockUISlider.value * 100)) + "%"
        
        fundLabel.text = String(tempFund) + "萬"
        fundPersent.text = String(Int(fundUISlider.value * 100)) + "%"
        
        annuityLabel.text = String(tempAnnuity) + "萬"
        annuityPersent.text = String(Int(annuityUISlider.value)) + "%"
        
        medicineLabel.text = String(tempMedicineInsurance) + "萬"
        medicinePersent.text = String(Int(medicineInsuranceUISlider.value)) + "%"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMoney()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        tempAnnuity = receivedAnnuity
        tempMedicineInsurance = receivedMedicineInsurance
        
        tempTotalMoney = tempDeposit + tempStock + tempFund + p.annuity + p.medicineInsurance + tempAnnuity + tempMedicineInsurance
        
        totalMoneyLabel.text = "總資產  " + String(tempTotalMoney) + "萬"
        depositUISlider.value = Float(Float(tempDeposit) / Float(tempTotalMoney))
        stockUISlider.value = Float(Float(tempStock) / Float(tempTotalMoney))
        fundUISlider.value = Float(Float(tempFund) / Float(tempTotalMoney))
        annuityUISlider.value = Float(tempAnnuity)
        medicineInsuranceUISlider.value = Float(tempMedicineInsurance)

        
        assetPersent.text = String(Int(depositUISlider.value * 100)) + "%"
        insurancePersent.text = String(Int(Float(p.annuity + p.medicineInsurance + tempAnnuity + tempMedicineInsurance) / Float(tempTotalMoney) * 100)) + "%"
        investPersent.text = String(Int((stockUISlider.value + fundUISlider.value) * 100)) + "%"

        depositLabel.text = String(tempDeposit) + "萬"
        depositPersent.text = String(Int(depositUISlider.value * 100)) + "%"
        
        stockLabel.text = String(tempStock) + "萬"
        stockPersent.text = String(Int(stockUISlider.value * 100)) + "%"
        
        fundLabel.text = String(tempFund) + "萬"
        fundPersent.text = String(Int(fundUISlider.value * 100)) + "%"
        
        annuityLabel.text = String(tempAnnuity) + "萬"
        annuityPersent.text = String(Int(annuityUISlider.value)) + "%"
        
        medicineLabel.text = String(tempMedicineInsurance) + "萬"
        medicinePersent.text = String(Int(medicineInsuranceUISlider.value)) + "%"
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        let p = SystemSetting.getPlayer()
//        
//        p.stock = Int(Float(stockUISlider.value) * Float(tempTotalMoney))
//        p.fund = Int(Float(fundUISlider.value) * Float(tempTotalMoney))
//        p.annuity += Int(Float(annuityUISlider.value))
//        p.medicineInsurance += Int(Float(medicineInsuranceUISlider.value))
//        p.deposit = tempTotalMoney - p.stock - p.fund - p.annuity - p.medicineInsurance
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toConfirm" {
            let p = SystemSetting.getPlayer()

            let secondVC = segue.destination as! AssetConfirmViewController
            
            let stock = Int(Float(stockUISlider.value) * Float(tempTotalMoney))
            let fund = Int(Float(fundUISlider.value) * Float(tempTotalMoney))
            let annuity = Int(Float(annuityUISlider.value))
            let medicineInsurance = Int(Float(medicineInsuranceUISlider.value))
            
            secondVC.receivedStock = stock
            secondVC.receivedFund = fund
            secondVC.receivedAnnuity = annuity
            secondVC.receivedMedicineInsurance = medicineInsurance

            secondVC.receivedDeposit = tempTotalMoney - stock - fund - annuity - medicineInsurance - p.annuity - p.medicineInsurance
        }
    }
    
    @IBAction func ToConfirmBtn_Click(_ sender: UIButton) {
        
    }
    
    
}
