//
//  Story.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/17.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import Foundation
import UIKit

class Story {
    private static var story: Story?
    
    var events: [String: Event] = [:]
    var questions: [String: Question] = [:]
    var choices: [String: Choice] = [:]
    var results: [String: Result] = [:]
    
    static func getStory() -> Story {
        if Story.story == nil {
            Story.story = Story()
        }
        
        return Story.story!
    }
    
    init() {
        if let url = Bundle.main.url(forResource: "event", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let eventJ = try decoder.decode([EventJ].self, from: data)
                for i in eventJ {
                    events[i.index!] = Event(ej: i)
                }
            } catch {
                print("error:\(error)")
            }
        }
        if let url = Bundle.main.url(forResource: "question", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let questionJ = try decoder.decode([QuestionJ].self, from: data)
                for i in questionJ {
                    questions[i.index!] = Question(qj: i)
                }
            } catch {
                print("error:\(error)")
            }
        }
        if let url = Bundle.main.url(forResource: "choice", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let choiceJ = try decoder.decode([ChoiceJ].self, from: data)
                for i in choiceJ {
                    choices[i.index!] = Choice(cj: i)
                }
            } catch {
                print("error:\(error)")
            }
        }
        if let url = Bundle.main.url(forResource: "result", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let resultJ = try decoder.decode([ResultJ].self, from: data)
                for i in resultJ {
                    results[i.index!] = Result(rj: i)
                }
            } catch {
                print("error:\(error)")
            }
        }
    }
}

class Event {
    var index: String
    var img: UIImage?
    var content: String
    var year: Int
    var connectQuestion: String?
    var absResult: String?
    
    init(ej: EventJ) {
        self.index = ej.index!
        self.img = UIImage(named: ej.imgUrl!)
        self.content = ej.eventContent!
        self.year = Int(Float(ej.year!)!)
        if ej.connectEvent?.first == "Q" {
            self.connectQuestion = ej.connectEvent
            self.absResult = nil
        }
        else {
            self.connectQuestion = nil
            self.absResult = ej.connectEvent
        }
    }
}

class Question {
    var index: String
    var img: UIImage?
    var content: String
    var choice1: String?
    var choice2: String?
    
    init(qj: QuestionJ) {
        self.index = qj.index!
        self.img = UIImage(named: qj.imgUrl!)
        self.content = qj.questionContent!
        self.choice1 = qj.connectEvent![0]
        self.choice2 = qj.connectEvent![1]
    }
}

class Choice {
    var index: String
    var img: UIImage?
    var content: String
    var nextQuestion: String?
    var connectResult: [String?] = []
    
    init(cj: ChoiceJ) {
        self.index = cj.index!
        self.img = UIImage(named: cj.imgUrl ?? "")
        self.content = cj.content!
        for i in cj.connectEvent! {
            if i.first == "Q" {
                self.nextQuestion = i
            }
            else {
                self.connectResult.append(i)
            }
        }
    }
    
    func getMainValue() -> Character {
        if(connectResult != []){
            let s = Story.getStory()
            let r = s.results[connectResult[0]!]!
            if(r.valueChange[0] != ""){
                return r.valueChange[0].first!
            }
            else{
                return "M"
            }
        }
        return "M"
    }
    
    func getResult() -> String {
        let s = Story.getStory()
        let x = Float.random(in: 0...1)
        var nowRate: Float = 0.0
        
        for rs in connectResult {
            let r = s.results[rs!]!
            nowRate += r.prob
            
            if x >= nowRate {
                return rs!
            }
        }
        return connectResult[0]!
    }
}

class Result {
    var index: String
    var img: UIImage?
    var content: String
    var prob: Float
    var year: Int
    var connectEvent: String
    var valueChange: [String]
    var willHappenedEvent: [String]
    
    init(rj: ResultJ) {
        self.index = rj.index!
        self.img = UIImage(named: rj.imgUrl!)
        self.content = rj.resultContent!
        self.prob = Float(rj.prob!) ?? 1.0
        self.year = Int(Float(rj.year!) ?? 0.0)
        self.connectEvent = rj.connectEvent!
        self.valueChange = rj.valueChanged!
        self.willHappenedEvent = rj.willHappenedEvent!
    }
}

class EventJ: Codable {
    var index: String?
    var imgUrl: String?
    var eventContent: String?
    var prob: String?
    var year: String?
    var connectEvent: String?
}

class QuestionJ: Codable {
    var index: String?
    var imgUrl: String?
    var questionContent: String?
    var connectEvent: [String]?
}

class ChoiceJ: Codable {
    var index: String?
    var imgUrl: String?
    var content: String?
    var connectEvent: [String]?
}

class ResultJ: Codable {
    var index: String?
    var imgUrl: String?
    var resultContent: String?
    var prob: String?
    var year: String?
    var connectEvent: String?
    var valueChanged: [String]?
    var willHappenedEvent: [String]?
}
