//
//  Step1ViewController.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/14/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import UIKit

class Step1ViewController: UIViewController {

    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var step1: UIImageView!
    
    @IBOutlet weak var hand: UIImageView!
    
    @IBOutlet weak var hand2: UIImageView!
    @IBOutlet weak var desc1: UITextView!
    @IBOutlet weak var desc2: UITextView!
    @IBAction func goBack(_ sender: Any) {
        performSegue(withIdentifier: "backToHelp", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, animations: {
            self.step1.alpha = 1
        }) { (true) in
            self.showHand()
        }
    }
    
    func showHand() {
        UIView.animate(withDuration: 1) {
            self.hand.alpha = 1
            self.hand2.alpha = 1
            self.desc1.alpha = 1
            self.desc2.alpha = 1
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
        hand2.layer.add(hover, forKey: "myHoverAnimation")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        step1.alpha = 0
        hand.alpha = 0
        hand2.alpha = 0
        desc1.alpha = 0
        desc2.alpha = 0
   
        hand.isUserInteractionEnabled = true
        
        step1.layer.shadowColor = UIColor.gray.cgColor
        step1.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        step1.layer.shadowOpacity = 0.5
        step1.layer.shadowRadius = 1.0
        step1.clipsToBounds = false
        
//        desc1.layer.cornerRadius = 4.0
        desc1.layer.shadowColor = UIColor.gray.cgColor
        desc1.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        desc1.layer.shadowOpacity = 0.3
        desc1.layer.shadowRadius = 1.0
        desc1.layer.borderWidth = 1.5
        desc1.clipsToBounds = false
        
//        desc2.layer.cornerRadius = 4.0
        desc2.layer.shadowColor = UIColor.gray.cgColor
        desc2.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        desc2.layer.shadowOpacity = 0.3
        desc2.layer.shadowRadius = 1.0
        desc2.layer.borderWidth = 1.5
        desc2.clipsToBounds = false

        
        customizeNavBar()

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
