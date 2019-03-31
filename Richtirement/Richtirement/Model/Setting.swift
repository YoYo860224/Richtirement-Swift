//
//  MetaData.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/17.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import Foundation
import GameplayKit

class SystemSetting {
    static let AnnuityMax = 50;              // 年金每年最多增加多少
    static let MedicineInsuranceMax = 50;    // 醫療保險每年最多增加多少
    
    static var nowPlayerName = ""
    static var Players: [String: PlayerData] = [:]
    
    static func getPlayer() -> PlayerData {
        return Players[nowPlayerName]!
    }
}

class PlayerData: Codable {
    // 基本人設
    var name: String = ""
    var age:Int = 55
    var gender: Int = 1                 // 1 is male, 0 is female

    var hasParent: Bool = false
    var hasFriend: Bool = false
    var hasCouple: Bool = false
    var hasChilds: Bool = false
    
    // 四大數值
    var money = 100
    var phychological = 75
    var healthy = 75
    var social = 75
    
    var InitMoney: Int = 0
    var deposit: Int = 1500             // 存款
    var stock: Int = 0                  // 股票
    var fund: Int = 0                   // 基金
    var annuity: Int = 0                // 年金
    var medicineInsurance: Int = 0      // 醫療險
    
    var resultRecord: [String] = []
    
    var annuityRecord:[Double] = []
    var livingExpenseRecord: [Double] = []
    var stockRecord: [Double] = []
    var fundRecord: [Double] = []

    // 故事內容
    var nowEvent: String = ""
    var eventIDs: [String] = ["E0"]
    
    func getMoneyPersent() -> Int{
        return min(Int(Float(deposit + stock + fund) / (Float(InitMoney) * 0.4) * 100), 100)
    }
    
    func payMoney(money: Int) -> Bool {
        var money = money
        if(money > self.deposit){
            money -= self.deposit
            self.deposit = 0
            if(money > self.stock){
                money -= self.stock
                self.stock = 0
                if(money > self.fund){
                    money -= self.fund
                    self.fund = 0
                    // game over
                    return false
                }
                else{
                    self.fund -= money
                    return true
                }
            }
            else{
                self.stock -= money
                return true
            }
        }
        else{
            self.deposit -= money
            return true
        }
    }
    
    func getNextEvent() -> Bool{
        if eventIDs.count > 0 {
            let number = Int.random(in: 0..<eventIDs.count)
            nowEvent = eventIDs[number]
            eventIDs.remove(at: number)
            return true
        }
        else {
            // 沒事件 死亡？
            return false
        }
    }

    func isGameOver() -> Int{
        if(self.deposit <= 0 && self.stock <= 0 && self.fund <= 0){
            return 1
        }
        else if(self.phychological <= 0){
            return 2
        }
        else if(self.healthy <= 0){
            return 3
        }
        else if(self.social <= 0){
            return 4
        }
        return 0
    }
    
    func yearMoneyChange(){
        self.livingExpenseRecord.append(0)
        self.stockRecord.append(0)
        self.fundRecord.append(0)
        self.annuityRecord.append(0)
        
        if(self.age > 65){
            let annuityChange = 0.1 * Float(annuity)
            self.annuityRecord[self.annuityRecord.count - 1] += Double(Int(annuityChange))
            self.deposit += Int(annuityChange)
        }
        
        let depositChange = (1.0 - self.randomNormalNumber(deviation: 0.003, mean: 0.97)) * max(Float(deposit + stock + fund), 1000)
        let _ = self.payMoney(money: Int(depositChange))
        self.livingExpenseRecord[self.livingExpenseRecord.count - 1] += Double(Int(depositChange))
        
        let stockChange = (self.randomNormalNumber(deviation: 0.2, mean: 1.0) - 1.0) * Float(stock)
        stock += Int(stockChange)
        print(stockChange)
        self.stockRecord[self.stockRecord.count - 1] += Double(stockChange)


        let fundChange = (self.randomNormalNumber(deviation: 0.05, mean: 1.0) - 1.0) * Float(fund)
        fund += Int(fundChange)
        print(fundChange)
        self.fundRecord[self.fundRecord.count - 1] += Double(fundChange)

    }
    
    func randomNormalNumber(deviation:Float, mean:Float) -> Float{
        let u1 = Float(arc4random()) / Float(UINT32_MAX) // uniform distribution
        let u2 = Float(arc4random()) / Float(UINT32_MAX) // uniform distribution
        let f1 = sqrt(-2 * log(u1));
        let f2 = 2 * Float.pi * u2;
        let g1 = f1 * cos(f2); // gaussian distribution
//        var g2 = f1 * sin(f2); // gaussian distribution
        return g1 * deviation + mean
    }
    
    // TODO: - 讀存擋範例 就交給你了
    
//    func save() {
//        let fm = FileManager()
//        let path = NSHomeDirectory() + "/tmp/" + self.name + ".json"
//        if !fm.fileExists(atPath: path) {
//            fm.createFile(atPath: path, contents: nil, attributes: nil)
//        }
//
//        let url = URL(fileURLWithPath: path)
//
//        if let data = try? JSONEncoder().encode(self) {
//            try? data.write(to: url)
//        }
//    }
//
//    func load() {
//        let fm = FileManager()
//        let path = NSHomeDirectory() + "/tmp/" + self.name + ".json"
//        if !fm.fileExists(atPath: path) {
//            fm.createFile(atPath: path, contents: nil, attributes: nil)
//        }
//
//        let url = URL(fileURLWithPath: path)
//
//        if let data = try? Data(contentsOf: url) {
//            let x = try? JSONDecoder().decode(PlayerData.self, from: data)
//        }
//    }
}
