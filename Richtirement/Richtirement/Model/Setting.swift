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
    
    static let nowPlayer = ""
    static let Players: [PlayerData] = []
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
