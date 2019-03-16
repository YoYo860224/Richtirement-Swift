//
//  MainGameViewController.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/16.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit

class MainGameView1Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func TapToNext(_ sender: Any) {
        performSegue(withIdentifier: "aaa", sender: nil)
    }
}
