//
//  Step3.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/14/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import UIKit

class Step3: UIViewController {

    @IBOutlet weak var step3: UIImageView!
    @IBOutlet weak var hand: UIImageView!
    @IBOutlet weak var desc: UITextView!
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToHelp3", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        step3.alpha = 0
        hand.alpha = 0
        desc.alpha = 0
        
        hand.isUserInteractionEnabled = true
        
        step3.layer.shadowColor = UIColor.gray.cgColor
        step3.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        step3.layer.shadowOpacity = 0.5
        step3.layer.shadowRadius = 1.0
        step3.clipsToBounds = false
        
        //        desc1.layer.cornerRadius = 4.0
        desc.layer.shadowColor = UIColor.gray.cgColor
        desc.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        desc.layer.shadowOpacity = 0.3
        desc.layer.shadowRadius = 1.0
        desc.layer.borderWidth = 1.5
        desc.clipsToBounds = false
        
        customizeNavBar()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, animations: {
            self.step3.alpha = 1
        }) { (true) in
            self.showHand()
        }
    }
    
    func showHand() {
        UIView.animate(withDuration: 1) {
            self.hand.alpha = 1
            self.desc.alpha = 1
            self.animateHand()
        }
    }
    
    func animateHand() {
        let hover = CABasicAnimation(keyPath: "position")
        
        hover.isAdditive = true
        hover.fromValue = NSValue(cgPoint: CGPoint.zero)
        hover.toValue = NSValue(cgPoint: CGPoint(x: 0.0, y: 10.0))
        hover.autoreverses = true
        hover.duration = 1.5
        hover.repeatCount = Float.infinity
        
        hand.layer.add(hover, forKey: "myHoverAnimation")
        
    }
    
    func customizeNavBar() {
        
        
        let logo = UIImage(named: "positivity (12).png")
        
        let imageView = UIImageView(image:logo)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.navigationItem.titleView = imageView
        
        
        navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        
    }
    


}
