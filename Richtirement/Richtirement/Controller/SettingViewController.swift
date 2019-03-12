//
//  SettingViewController.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/12.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var progressBarOuter: UIView!
    @IBOutlet weak var progressBarInner: UIView!
    
    @IBOutlet weak var qScrollView: UIScrollView!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var femaleRdBtn: RadioBtn!
    @IBOutlet weak var maleRdBtn: RadioBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        progressBarOuter.layer.cornerRadius = 2.5
        progressBarOuter.layer.masksToBounds = true
        
        qScrollView.delaysContentTouches = false
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: nameTF.frame.height - 2, width: nameTF.frame.width, height: 2.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        nameTF.borderStyle = UITextField.BorderStyle.none
        nameTF.layer.addSublayer(bottomLine)
        
        maleRdBtn.check()
        maleRdBtn.checkGroup = [femaleRdBtn]
        femaleRdBtn.checkGroup = [maleRdBtn]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
