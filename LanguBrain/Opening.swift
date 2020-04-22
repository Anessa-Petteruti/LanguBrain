//
//  Opening.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/8/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import UIKit

class Opening:UIViewController {
    
    let relativeFontConstant:CGFloat = 0.045
    let relativeFontConstant2:CGFloat = 0.03
    
    @IBOutlet weak var langubrainTitle: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var textOpening: UILabel!
    @IBOutlet weak var arrowOpening: UIImageView!
    @IBOutlet var wholeView: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, animations: {
            self.langubrainTitle.alpha = 1
        }) { (true) in
            self.showLogoOpening()
        }
    }
    
    func showLogoOpening() {
        UIView.animate(withDuration: 1, animations: {
            self.logo.alpha = 1
        }, completion: { (true) in
            self.showTextOpening()
        })
    }
    
    func showTextOpening() {
        UIView.animate(withDuration: 1, animations: {
            self.textOpening.alpha = 1
        }) { (true) in
            self.showArrowOpening()
        }
    }
    
    
    func showArrowOpening() {
        UIView.animate(withDuration: 1) {
            self.arrowOpening.alpha = 1
            self.animateArrow()
        }
    }
    
    func animateArrow() {
        let hover = CABasicAnimation(keyPath: "position")
        
        hover.isAdditive = true
        hover.fromValue = NSValue(cgPoint: CGPoint.zero)
        hover.toValue = NSValue(cgPoint: CGPoint(x: 0.0, y: 10.0))
        hover.autoreverses = true
        hover.duration = 1.5
        hover.repeatCount = Float.infinity
        
        arrowOpening.layer.add(hover, forKey: "myHoverAnimation")
    }
    
    @objc func swipeGesture(sendr:UIGestureRecognizer) {
        performSegue(withIdentifier: "afterSwipeSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        langubrainTitle.alpha = 0
        logo.alpha = 0
        textOpening.alpha = 0
        arrowOpening.alpha = 0
        
        arrowOpening.isUserInteractionEnabled = true
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        
        arrowOpening.addGestureRecognizer(swipeRight)
        wholeView.addGestureRecognizer(swipeRight)
        
        langubrainTitle.font = langubrainTitle.font?.withSize(self.view.frame.height * relativeFontConstant)
        textOpening.font = textOpening.font?.withSize(self.view.frame.height * relativeFontConstant2)

    }
}
