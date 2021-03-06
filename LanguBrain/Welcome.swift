//
//  Opening.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/8/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import UIKit

class Welcome:UIViewController {
    
    let relativeFontConstant:CGFloat = 0.04
    let relativeFontConstant2:CGFloat = 0.023
    let relativeFontConstant3:CGFloat = 0.028
 

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var continueLabel: UILabel!
    
    @IBAction func continueButton(_ sender: Any) {
        performSegue(withIdentifier: "goToSpeechRecognition", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.font = welcomeLabel.font?.withSize(self.view.frame.height * relativeFontConstant)
        text.font = text.font?.withSize(self.view.frame.height * relativeFontConstant2)
        continueLabel.font = continueLabel.font?.withSize(self.view.frame.height * relativeFontConstant3)

    }
}
