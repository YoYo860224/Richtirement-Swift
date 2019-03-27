//
//  ViewController.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/4.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startBtn_Click(_ sender: Any) {
        performSegue(withIdentifier: "first", sender: nil)
    }
}

