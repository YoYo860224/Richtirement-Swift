//
//  MainGameView2Controller.swift
//  Richtirement
//
//  Created by 陳祐丞 on 2019/3/17.
//  Copyright © 2019 陳祐丞. All rights reserved.
//

import UIKit

class MainGameView2Controller: UIViewController {
    @IBOutlet weak var propM: PropImageView!
    @IBOutlet weak var propP: PropImageView!
    @IBOutlet weak var propH: PropImageView!
    @IBOutlet weak var propS: PropImageView!
    
    @IBOutlet weak var gameResultTexOuter: UIView!
    @IBOutlet weak var gameResultText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.gameResultTexOuter.frame.size)
        gradient.colors = [
            UIColor(red: 255/255, green: 209/255, blue: 102/255, alpha: 1.0).cgColor,
            UIColor(red: 231/255, green:  98/255, blue: 122/255, alpha: 1.0).cgColor,
            UIColor(red:  63/255, green: 174/255, blue: 222/255, alpha: 1.0).cgColor,
            UIColor(red:  62/255, green: 195/255, blue: 160/255, alpha: 1.0).cgColor
        ]
        gradient.locations = [ 0.0, 0.37, 0.77, 1.0]
        
        let shape = CAShapeLayer()
        shape.lineWidth = 4
        shape.path = UIBezierPath(rect: self.gameResultTexOuter.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.gameResultTexOuter.layer.addSublayer(gradient)
    }
}

class PropImageView: UIView {
    @IBInspectable var image: UIImage?
    let top: CALayer = CALayer()
    
    func initSelf() {
        let mask = CALayer()
        mask.frame = CGRect(x: 0, y: 0, width: 45  , height: 45)
        mask.contents = image?.cgImage
        self.layer.mask = mask

        top.backgroundColor = UIColor(white: 147/255, alpha: 1.0).cgColor
        top.frame = CGRect(x: 0, y: 0, width: 45, height: 20)
        self.layer.addSublayer(top)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        initSelf()
    }
    
    func changeRatio(ratio: Float) {
        let ratioHeight = 45 * (1 - ratio)
        top.frame = CGRect(x: 0, y: 0, width: 45, height: Int(ratioHeight))
    }
}
