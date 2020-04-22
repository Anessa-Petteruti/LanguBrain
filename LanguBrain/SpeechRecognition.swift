//
//  SpeechRecognition.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/8/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import UIKit

class SpeechRecognition:UIViewController {
    
    let relativeFontConstant:CGFloat = 0.04
    let relativeFontConstant2:CGFloat = 0.023
    let relativeFontConstant3:CGFloat = 0.028
    
    
    @IBOutlet weak var speechRec: UILabel!
    
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var continueLabel: UILabel!
    
    @IBOutlet weak var backText: UIButton!
    @IBAction func continueButton(_ sender: Any) {
        performSegue(withIdentifier: "goToLanguageDetection", sender: self)
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToWelcome", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechRec.font = speechRec.font?.withSize(self.view.frame.height * relativeFontConstant)
        text.font = text.font?.withSize(self.view.frame.height * relativeFontConstant2)
        continueLabel.font = continueLabel.font?.withSize(self.view.frame.height * relativeFontConstant3)

        
    }
}
