//
//  MetaData.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/17.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import Foundation

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
    
    
    var deposit: Int = 1500             // 存款
    var stock: Int = 0                  // 股票
    var fund: Int = 0                   // 基金
    var annuity: Int = 0                // 年金
    var medicineInsurance: Int = 0      // 醫療險
    
    // 故事內容
    var nowEvent: String = ""
    var eventIDs: [String] = ["E0"]
    
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
