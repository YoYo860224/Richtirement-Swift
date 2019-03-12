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
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func startBtn_Click(_ sender: Any) {
//        present(SecondViewController(), animated: true, completion: nil)
        performSegue(withIdentifier: "aaa", sender: nil)
    }
}

