//
//  Walkthrough.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/7/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import UIKit
import OnboardKit

class Walkthrough: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    lazy var onboardingPages: [OnboardPage] = {
        let pageOne = OnboardPage(title: "LanguBrain",
                                  imageName: "langubrain-logo",
                                  description: "Translation in seconds.",
        advanceButtonTitle: "Continue")
        
        let pageTwo = OnboardPage(title: "Speech Recognition",
                                  imageName: "welcome-microphone",
                                  description: "For each of your habits an entry is created for every day you need to complete it.",
                                  advanceButtonTitle: "Continue")
        
        let pageThree = OnboardPage(title: "Language Detection",
                                    imageName: "welcome-detect",
                                    description: "By marking entries as Done you can track your progress on the path to success.",
                                    advanceButtonTitle: "Continue")
        
        let pageFour = OnboardPage(title: "Audio",
                                   imageName: "welcome-audio",
                                   description: "Turn on notifications to get reminders and keep up with your goals.",
                                   advanceButtonTitle: "Continue")
        
        return [pageOne, pageTwo, pageThree, pageFour]
    }()
    
    lazy var onboardingPagesAlternative: [OnboardPage] = {
        let pageOne = OnboardPage(title: "LanguBrain",
                                  imageName: "langubrain-logo",
                                  description: "Translation in seconds.",
        advanceButtonTitle: "Continue")
        
        let pageTwo = OnboardPage(title: "Speech Recognition",
                                  imageName: "welcome-microphone",
                                  description: "An entry is created for every day you need to complete each habit.",
                                  advanceButtonTitle: "Continue")
        
        let pageThree = OnboardPage(title: "Language Detection",
                                    imageName: "welcome-detect",
                                    description: "By marking entries as Done you can track your progress.",
                                    advanceButtonTitle: "Continue")
        
        let pageFour = OnboardPage(title: "Audio",
                                   imageName: "welcome-audio",
                                   description: "Turn on notifications to get reminders and keep up with your goals.",
                                   advanceButtonTitle: "Continue")
        
        return [pageOne, pageTwo, pageThree, pageFour]
    }()
    
    
    @IBAction func showOnboardingCustomTapped(_ sender: Any) {
        
        let tintColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        let titleColor = UIColor(red: 193/255, green: 193/255, blue: 193/255, alpha: 1)
        let boldTitleFont = UIFont(name:"PingFang SC", size:32)
        let mediumTextFont = UIFont(name:"PingFang SC", size:18)

        
        let appearanceConfiguration = OnboardViewController.AppearanceConfiguration(tintColor: tintColor, textColor: .black, backgroundColor: .white, titleFont: boldTitleFont!, textFont: mediumTextFont!)
        let onboardingVC = OnboardViewController(pageItems: onboardingPagesAlternative, appearanceConfiguration: appearanceConfiguration)
        onboardingVC.modalPresentationStyle = .formSheet
        onboardingVC.presentFrom(self, animated: true)
    }
    
    
    
    /// Only for the purpouses of the example.
    /// Not really asking for notifications permissions.
    private func showAlert(_ completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        let alert = UIAlertController(title: "Allow Notifications?",
                                      message: "LanguBrain wants to send you notifications",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion(true, nil)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(false, nil)
        })
        presentedViewController?.present(alert, animated: true)
    }
}


