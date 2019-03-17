//
//  ViewController.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/4.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startBtn_Click(_ sender: Any) {
        var isFirst = true
        
        if isFirst {
            performSegue(withIdentifier: "first", sender: nil)
        }
        else {
            performSegue(withIdentifier: "normal", sender: nil)
        }
    }
}

