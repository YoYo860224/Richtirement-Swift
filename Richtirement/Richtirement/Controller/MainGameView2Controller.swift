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
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var quetionView: UIView!
    @IBOutlet weak var questionContent: UITextView!
    
    @IBOutlet weak var c1View: UIView!
    @IBOutlet weak var c1TextView: UILabel!
    @IBOutlet weak var c1ImageView: UIImageView!
    
    @IBOutlet weak var c2View: UIView!
    @IBOutlet weak var c2TextView: UILabel!
    @IBOutlet weak var c2ImageView: UIImageView!

    @IBOutlet weak var gameResultView: UIView!
    @IBOutlet weak var gameResultTexOuter: UIView!
    @IBOutlet weak var gameResultTitle: UILabel!
    @IBOutlet weak var gameResultText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setStory()
        setUI()
    }
    
    func setStory() {
        propM.changeRatio(ratio: 0.1)
        propP.changeRatio(ratio: 0.2)
        propH.changeRatio(ratio: 0.3)
        propS.changeRatio(ratio: 0.4)
        
        let s = Story.getStory()
        let nowQuestion = s.questions["Q0"]
        let c1 = s.choices["C1"]
        let c2 = s.choices["C2"]
        
        imageView.image = s.events["E0"]?.img
        questionContent.text = nowQuestion?.content
        
        c1TextView.text = c1?.content
        c2TextView.text = c2?.content
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
    
    @IBAction func c1_Click(_ sender: Any) {
        let s = Story.getStory()
        let r = s.results["R0"]
        imageView.image = r?.img
        gameResultTitle.text = ""
        gameResultText.text = r?.content
        
        c1View.isHidden = true
        c2View.isHidden = true
        quetionView.isHidden = true
        gameResultView.isHidden = true
    }
    
    @IBAction func c2_Click(_ sender: Any) {
        let s = Story.getStory()
        let r = s.results["R1"]
        imageView.image = r?.img
        gameResultTitle.text = ""
        gameResultText.text = r?.content
        
        c1View.isHidden = true
        c2View.isHidden = true
        quetionView.isHidden = true
        gameResultView.isHidden = false
    }
    
    @IBAction func imageView_Click(_ sender: Any) {
        if quetionView.isHidden == true {
            gameResultView.isHidden = false
        }
    }
    
    
    @IBAction func gameResultView_Click(_ sender: Any) {
        performSegue(withIdentifier: "nextQuetion", sender: nil)
    }
}

class PropImageView: UIView {
    @IBInspectable var image: UIImage?
    var ratio: Float = 1.0
    let top: CALayer = CALayer()
    
    func initSelf() {
        let mask = UIImageView(frame: CGRect(x: 0, y: 0, width: 45  , height: 45))
        mask.image = image
        mask.contentMode = .scaleAspectFit
        self.layer.mask = mask.layer

        top.backgroundColor = UIColor(white: 147/255, alpha: 1.0).cgColor
        let ratioHeight = 45 * (1 - ratio)
        top.frame = CGRect(x: 0, y: 0, width: 45, height: Int(ratioHeight))
        self.layer.addSublayer(top)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        initSelf()
    }
    
    func changeRatio(ratio: Float) {
        self.ratio = ratio
        let ratioHeight = 45 * (1 - ratio)
        top.frame = CGRect(x: 0, y: 0, width: 45, height: Int(ratioHeight))
    }
}
