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
    @IBOutlet weak var progressBarTrCn: NSLayoutConstraint!
    @IBOutlet var top4Label: [UILabel]!
    
    @IBOutlet weak var qScrollView: UIScrollView!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var femaleRdBtn: RadioBtn!
    @IBOutlet weak var maleRdBtn: RadioBtn!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValue: UILabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerForKeyboardNotifications()
    }

    func setUI() {
        progressBarOuter.layer.cornerRadius = 2.5
        progressBarOuter.layer.masksToBounds = true
        
        qScrollView.delaysContentTouches = false
        qScrollView.delegate = self
        
        // Top progBar animate
        let progbarWidth = progressBarOuter.frame.width
        progressBarTrCn.constant = progbarWidth * 0.18
        
        // Page1 name text field
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: nameTF.frame.height - 2, width: nameTF.frame.width, height: 2.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        nameTF.borderStyle = UITextField.BorderStyle.none
        nameTF.layer.addSublayer(bottomLine)
        
        // Page2 gender select
        maleRdBtn.check()
        maleRdBtn.checkGroup = [femaleRdBtn]
        femaleRdBtn.checkGroup = [maleRdBtn]
        
        // Page4 show
        confirmBtn.isHidden = true
    }
    // Page 1 Text
    var originHeight: CGFloat = 0
    var keyBoardHeight: CGFloat = 0
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShown(_ notification: NSNotification) {
        if originHeight == 0 {
            originHeight = nameView.center.y
        }
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyBoardHeight = keyboardRectangle.height
        }
        nameView.center.y = originHeight - (keyBoardHeight - 150)
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        nameView.center.y = originHeight
    }
    
    @IBAction func TapToEndEditing(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // Page 4 Slider
    @IBAction func SliderDrag(_ sender: Any) {
        // thumb size is 57
        sliderValue.text = String(Int(5000 * slider.value))
        sliderValue.center.x = CGFloat(Float(slider.frame.minX + 14.25) + Float(slider.frame.width - 28.5) * slider.value)
    }
    
    
    @IBAction func confirmBtn_Click(_ sender: Any) {
        // after check
        performSegue(withIdentifier: "game", sender: nil)
    }
}

extension SettingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(pageControl.numberOfPages), height: 0)
        pageControl.currentPage = Int(pageNumber)
        
        for (i, label) in top4Label.enumerated() {
            if i == Int(pageNumber) {
                UIView.transition(with: label, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    label.textColor = UIColor(red: 255/255, green: 216/255, blue: 113/255, alpha: 1.0)
                }, completion: nil)
            }
            else {
                UIView.transition(with: label, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    label.textColor = UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1.0)
                }, completion: nil)
            }
        }
        
        let pageRatio = scrollView.contentOffset.x / scrollView.frame.size.width
        let pageRatioInt = Int(pageRatio)
        let pageRationFloat = pageRatio - CGFloat(pageRatioInt)
        
        let widRate:[CGFloat] = [0.18, 0.4, 0.7, 1]
        let progbWidth = progressBarOuter.frame.width
        if pageRatioInt < 3 {
            progressBarTrCn.constant = (widRate[pageRatioInt] + (widRate[pageRatioInt + 1] - widRate[pageRatioInt]) * pageRationFloat) * progbWidth
            
            if !self.confirmBtn.isHidden {
                print("x")
                UIView.transition(with: confirmBtn, duration: 0.3, options: .curveEaseInOut, animations: {
                    self.confirmBtn.isHidden = true
                }, completion: nil)
            }
        }
        else {
            UIView.transition(with: confirmBtn, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.confirmBtn.isHidden = false
            }, completion: nil)
        }
        
        self.view.endEditing(true)
    }
}
