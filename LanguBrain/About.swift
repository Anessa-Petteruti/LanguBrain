//
//  About.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/7/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import UIKit

class About: UIViewController {
    
    let relativeFontConstant:CGFloat = 0.029
    let relativeFontConstant2:CGFloat = 0.023
    let relativeFontConstant3:CGFloat = 0.028
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var mainText: UITextView!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var continueLabel: UILabel!
    @IBAction func learnMoreButton(_ sender: Any) {
        guard let url = URL(string: "https://www.anessapetteruti.com/langubrain") else { return }
        UIApplication.shared.open(url)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
        customizeNavBar()
        
//        view.setGradientBackground(colorOne: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), colorTwo: UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1))
    }
    
    @objc func sideMenus() {
        if revealViewController != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func customizeNavBar() {
        
        
        let logo = UIImage(named: "positivity (12).png")
        
        let imageView = UIImageView(image:logo)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.navigationItem.titleView = imageView
        
        
        navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        
        mainText.font = mainText.font?.withSize(self.view.frame.height * relativeFontConstant)
        text.font = text.font?.withSize(self.view.frame.height * relativeFontConstant2)
        continueLabel.font = continueLabel.font?.withSize(self.view.frame.height * relativeFontConstant3)
        
    }
}
