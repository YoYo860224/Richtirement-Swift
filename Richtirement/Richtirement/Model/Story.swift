//
//  Story.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/17.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import Foundation


class Event: Codable {
    var index: String?
    var imgUrl: String?
    var prop: String?
    var eventContent: String?
    var year: String?
    var connectEvent: String?
}

class Question: Codable {
    var index: String?
    var imgUrl: String?
    var questionContent: String?
    var Choice1: String?
    var Choice2: String?
}

class Choice: Codable {
    var index: String?
    var imgUrl: String?
    var content: String?
    var connectResult: String?
}

class Result: Codable {
    var index: String?
    var imgUrl: String?
    var prop: String?
    var eventContent: String?
    var year: String?
    var valueChange: [String]?
    var connectEvent: String?
}
