//
//  MenuSupportedLanguages.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/7/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import UIKit

class MenuSupportedLanguages: UITableViewController {

    @IBAction func goShop(_ sender: Any) {
        guard let url = URL(string: "https://apps.apple.com/tt/developer/anessa-petteruti/id1464196411") else { return }
        UIApplication.shared.open(url)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }



}
