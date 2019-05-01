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
    @IBOutlet weak var savingsInsuranceUISlider: UISlider!
    @IBOutlet weak var accidentInsuranceUISlider: UISlider!
    
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
    
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var savingsPersent: UILabel!
    
    @IBOutlet weak var accidentLabel: UILabel!
    @IBOutlet weak var accidentPersent: UILabel!
    
    @IBOutlet weak var annuityView: UIView!
    @IBOutlet weak var medicineView: UIView!
    @IBOutlet weak var savingsView: UIView!
    @IBOutlet weak var accidentView: UIView!
    
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
            savingsView.isHidden = true
            accidentView.isHidden = true
        }
    }
    
    var tempTotalMoney = 0
    var tempDeposit = 0
    var tempStock = 0
    var tempFund = 0
    var tempAnnuity = 0
    var tempMedicineInsurance = 0
    var tempSavingsInsurance = 0
    var tempAccidentInsurance = 0
    
    var receivedDeposit: Int = 0
    var receivedStock: Int = 0
    var receivedFund: Int = 0
    var receivedAnnuity: Int = 0
    var receivedMedicineInsurance: Int = 0
    var receivedSavingsInsurance: Int = 0
    var receivedAccidentInsurance: Int = 0
    
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
    @IBAction func SavingsUISlider(_ sender: UISlider) {
        sliderValueChanged(index: 4)
    }
    @IBAction func accidentUISlider(_ sender: UISlider) {
        sliderValueChanged(index: 5)
    }
    
    
    func sliderValueChanged(index: Int){
        let p = SystemSetting.getPlayer()
        let stockSlideValue = Float(stockUISlider.value)
        let fundSlideValue = Float(fundUISlider.value)
        let annuitySlideValue = Float(annuityUISlider.value)
        let medicineInsuranceSlideValue = Float(medicineInsuranceUISlider.value)
        let savingsSlideValue = Float(savingsInsuranceUISlider.value)
        let accidentSlideValue = Float(accidentInsuranceUISlider.value)
        
        tempDeposit = Int(Float(tempTotalMoney) - stockSlideValue - fundSlideValue - annuitySlideValue - medicineInsuranceSlideValue - savingsSlideValue - accidentSlideValue)
        
        if(tempDeposit <= 0){
            if(index == 0){
                stockUISlider.value = Float(tempTotalMoney) - fundSlideValue - annuitySlideValue - medicineInsuranceSlideValue - savingsSlideValue - accidentSlideValue
            }
            else if (index == 1){
                fundUISlider.value = Float(tempTotalMoney) - stockSlideValue - annuitySlideValue - medicineInsuranceSlideValue - savingsSlideValue - accidentSlideValue
            }
            else if(index == 2){
                annuityUISlider.value = Float(tempTotalMoney) - stockSlideValue - fundSlideValue - medicineInsuranceSlideValue - savingsSlideValue - accidentSlideValue
            }
            else if(index == 3){
                medicineInsuranceUISlider.value = Float(tempTotalMoney) - stockSlideValue - fundSlideValue - annuitySlideValue - savingsSlideValue - accidentSlideValue
            }
            else if(index == 4){
                savingsInsuranceUISlider.value = Float(tempTotalMoney) - stockSlideValue - fundSlideValue - annuitySlideValue - medicineInsuranceSlideValue - accidentSlideValue
            }
            else if(index == 5){
                accidentInsuranceUISlider.value = Float(tempTotalMoney) - stockSlideValue - fundSlideValue - annuitySlideValue - medicineInsuranceSlideValue - savingsSlideValue
            }
        }
        tempStock = Int(stockUISlider.value)
        tempFund = Int(fundUISlider.value)
        tempAnnuity = Int(annuityUISlider.value)
        tempMedicineInsurance = Int(medicineInsuranceUISlider.value)
        tempSavingsInsurance = Int(savingsInsuranceUISlider.value)
        tempAccidentInsurance = Int(accidentInsuranceUISlider.value)
        
        
        tempDeposit = Int(Float(tempTotalMoney) - Float(tempFund) - Float(tempStock) - Float(tempAnnuity) - Float(tempMedicineInsurance) - Float(tempSavingsInsurance) - Float(tempAccidentInsurance))

        depositUISlider.value = Float(tempDeposit)
        
        
        assetPersent.text = String(Int(depositUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        insurancePersent.text = String(Int(Float(tempAnnuity + tempMedicineInsurance + tempSavingsInsurance + tempAccidentInsurance) / Float(tempTotalMoney) * 100)) + "%"
        investPersent.text = String(Int((stockUISlider.value + fundUISlider.value) / Float(tempTotalMoney) * 100)) + "%"
        
        depositLabel.text = String(tempDeposit) + "萬"
        depositPersent.text = String(Int(depositUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        
        stockLabel.text = String(tempStock) + "萬"
        stockPersent.text = String(Int(stockUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        
        fundLabel.text = String(tempFund) + "萬"
        fundPersent.text = String(Int(fundUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        
        annuityLabel.text = String(tempAnnuity) + "萬"
        annuityPersent.text = String(Int(annuityUISlider.value - Float(p.annuity))) + "%"
        
        medicineLabel.text = String(tempMedicineInsurance) + "萬"
        medicinePersent.text = String(Int(medicineInsuranceUISlider.value - Float(p.medicineInsurance))) + "%"
        
        savingsLabel.text = String(tempSavingsInsurance) + "萬"
        savingsPersent.text = String(Int(savingsInsuranceUISlider.value - Float(p.savingsInsurance))) + "%"
        
        accidentLabel.text = String(tempAccidentInsurance) + "萬"
        accidentPersent.text = String(Int(accidentInsuranceUISlider.value - Float(p.accidentInsurance))) + "%"
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

        if(receivedSavingsInsurance != p.savingsInsurance && receivedSavingsInsurance != 0){
            tempSavingsInsurance = receivedSavingsInsurance
        }
        else{
            tempSavingsInsurance = p.savingsInsurance
        }
        
        if(receivedAccidentInsurance != p.accidentInsurance && receivedAccidentInsurance != 0){
            tempAccidentInsurance = receivedAccidentInsurance
        }
        else{
            tempAccidentInsurance = p.accidentInsurance
        }

        tempTotalMoney = tempDeposit + tempStock + tempFund + tempAnnuity + tempMedicineInsurance + tempSavingsInsurance + tempAccidentInsurance

        depositUISlider.maximumValue = Float(tempTotalMoney)
        stockUISlider.maximumValue = Float(tempTotalMoney)
        fundUISlider.maximumValue = Float(tempTotalMoney)
        
        annuityUISlider.minimumValue = Float(p.annuity)
        medicineInsuranceUISlider.minimumValue = Float(p.medicineInsurance)
        savingsInsuranceUISlider.minimumValue = Float(p.savingsInsurance)
        accidentInsuranceUISlider.minimumValue = Float(p.accidentInsurance)
        
        annuityUISlider.maximumValue = Float(p.annuity) + 100
        medicineInsuranceUISlider.maximumValue = Float(p.medicineInsurance) + 100
        savingsInsuranceUISlider.maximumValue = Float(p.accidentInsurance) + 100
        accidentInsuranceUISlider.maximumValue = Float(p.accidentInsurance) + 100
        
        totalMoneyLabel.text = "總資產  " + String(tempTotalMoney) + "萬"
        depositUISlider.value = Float(tempDeposit)
        stockUISlider.value = Float(tempStock)
        fundUISlider.value = Float(tempFund)
        annuityUISlider.value = Float(tempAnnuity)
        medicineInsuranceUISlider.value = Float(tempMedicineInsurance)
        savingsInsuranceUISlider.value = Float(tempSavingsInsurance)
        accidentInsuranceUISlider.value = Float(tempAccidentInsurance)
        
        
        assetPersent.text = String(Int(depositUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        insurancePersent.text = String(Int(Float(tempAnnuity + tempMedicineInsurance + tempSavingsInsurance + tempAccidentInsurance) / Float(tempTotalMoney) * 100)) + "%"
        investPersent.text = String(Int((stockUISlider.value + fundUISlider.value) / Float(tempTotalMoney) * 100)) + "%"
        
        depositLabel.text = String(tempDeposit) + "萬"
        depositPersent.text = String(Int(depositUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        
        stockLabel.text = String(tempStock) + "萬"
        stockPersent.text = String(Int(stockUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        
        fundLabel.text = String(tempFund) + "萬"
        fundPersent.text = String(Int(fundUISlider.value / Float(tempTotalMoney) * 100)) + "%"
        
        annuityLabel.text = String(tempAnnuity) + "萬"
        annuityPersent.text = String(Int(annuityUISlider.value - Float(p.annuity))) + "%"
        
        medicineLabel.text = String(tempMedicineInsurance) + "萬"
        medicinePersent.text = String(Int(medicineInsuranceUISlider.value - Float(p.medicineInsurance))) + "%"
        
        savingsLabel.text = String(tempSavingsInsurance) + "萬"
        savingsPersent.text = String(Int(savingsInsuranceUISlider.value - Float(p.savingsInsurance))) + "%"
        
        accidentLabel.text = String(tempAccidentInsurance) + "萬"
        accidentPersent.text = String(Int(accidentInsuranceUISlider.value - Float(p.accidentInsurance))) + "%"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toConfirm" {
            let secondVC = segue.destination as! AssetConfirmViewController
            
            let stock = Int(Float(stockUISlider.value))
            let fund = Int(Float(fundUISlider.value))
            let annuity = Int(Float(annuityUISlider.value))
            let medicineInsurance = Int(Float(medicineInsuranceUISlider.value))
            let savingsInsurance = Int(Float(savingsInsuranceUISlider.value))
            let accidentInsurance = Int(Float(accidentInsuranceUISlider.value))
            
            secondVC.receivedStock = stock
            secondVC.receivedFund = fund
            secondVC.receivedAnnuity = annuity
            secondVC.receivedMedicineInsurance = medicineInsurance
            secondVC.receivedSavingsInsurance = savingsInsurance
            secondVC.receivedAccidentInsurance = accidentInsurance
            
            secondVC.receivedDeposit = tempTotalMoney - stock - fund - annuity - medicineInsurance - savingsInsurance - accidentInsurance
        }
    }
}
