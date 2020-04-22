//
//  Help.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/7/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import UIKit

class Help: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    let relativeFontConstant:CGFloat = 0.03
    
    @IBOutlet weak var helpText: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = ["Step 1: Select", "Step 2: Speak", "Step 3: Translate", "Step 4: Hear", "Step 5: Detect"]
    var icons: [UIImage] = []

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            performSegue(withIdentifier: "step1Segue", sender: self)
        }
        if indexPath.row == 1 {
            performSegue(withIdentifier: "step2Segue", sender: self)
        }
        if indexPath.row == 2 {
            performSegue(withIdentifier: "step3Segue", sender: self)
        }
        if indexPath.row == 3 {
            performSegue(withIdentifier: "step4Segue", sender: self)
        }
        if indexPath.row == 4 {
            performSegue(withIdentifier: "step5Segue", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        icons.append(UIImage(named: "first-step.png")!)
        icons.append(UIImage(named: "speaking.png")!)
        icons.append(UIImage(named: "third-step.png")!)
        icons.append(UIImage(named: "fourth-step.png")!)
        icons.append(UIImage(named: "fifth-step.png")!)
        

        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            
            cell.textLabel?.text = (items[indexPath.row])
            cell.textLabel?.font = UIFont(name:"PingFang SC", size:19)
            cell.imageView?.image = icons[indexPath.row]
//            cell.layer.borderWidth = 20
//            cell.layer.borderColor = UIColor.clear.cgColor
//            cell.layer.shadowOffset = CGSize(width:2, height:1)
//            cell.layer.shadowOpacity = 0.2
//            cell.layer.masksToBounds = false

//            cell.imageView?.frame = CGRect(x:0,y:0,width:10,height:10)
//            cell.imageView?.translatesAutoresizingMaskIntoConstraints = true
//            cell.imageView?.contentMode = .scaleAspectFit


            cell.accessoryType = .disclosureIndicator
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
            return cell
        }
        
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
        customizeNavBar()
        
//        view.setGradientBackground(colorOne: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), colorTwo: UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: "loadingCell")
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
        
        helpText.font = helpText.font?.withSize(self.view.frame.height * relativeFontConstant)
        
    }
}
