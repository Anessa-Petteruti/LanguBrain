//
//  PopUp.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/21/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import UIKit

class PopUp: UIViewController {
    
    @IBOutlet weak var popUp: UIView!
    
    @IBAction func closeButton(_ sender: Any) {
        self.removeAnimate()
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25) {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }
        self.view.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        popUp.layer.shadowColor = UIColor.black.cgColor
        popUp.layer.shadowOpacity = 1
        popUp.layer.shadowOffset = CGSize.zero
        popUp.layer.shadowRadius = 25
        popUp.layer.borderColor = UIColor.white.cgColor
        popUp.layer.borderWidth = 1.0
//        popUp.layer.cornerRadius = 8.0
        popUp.clipsToBounds = true
        
        showAnimate()
        
    }
    
    
    
    
}

