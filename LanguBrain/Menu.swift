//
//  Menu.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/6/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import UIKit

class Menu: UITableViewController {

    @IBAction func goShop(_ sender: Any) {
        guard let url = URL(string: "https://apps.apple.com/tt/developer/anessa-petteruti/id1464196411") else { return }
        UIApplication.shared.open(url)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)

    }


}
