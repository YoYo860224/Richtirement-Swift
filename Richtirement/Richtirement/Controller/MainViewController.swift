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
        // TODO:  如果使用者不是第一次用 換成 segue 到 record select
        performSegue(withIdentifier: "first", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showAction" {
//            let toViewController = segue.destination as UIViewController
//            toViewController.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
//        }
//    }
}

