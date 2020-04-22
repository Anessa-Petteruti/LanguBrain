//
//  SupportedLanguages.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/7/19.
//  Copyright © 2019 Anessa Petteruti. All rights reserved.
//

import UIKit

class SupportedLanguages: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    var items = ["LanguBrain supports 50 languages from Arabic to Portuguese to Thai:", "Afrikaans 🇿🇦", "Albanian 🇦🇱", "Arabic 🇸🇦", "Azerbaijani 🇦🇿", "Belarusian 🇧🇾", "Bulgarian 🇧🇬", "Catalan 🇪🇸", "Chinese (Simplified) 🇨🇳", "Chinese (Traditional) 🇨🇳", "Croatian 🇭🇷", "Czech 🇨🇿", "Danish 🇩🇰", "Dutch 🇳🇱", "English 🇺🇸", "Estonian 🇪🇪", "Filipino 🇵🇭", "Finnish 🇫🇮", "French 🇫🇷", "Georgian 🇬🇪", "German 🇩🇪", "Greek 🇬🇷", "Haitian Creole 🇭🇹", "Hebrew 🇮🇱", "Hindi 🇮🇳", "Hungarian 🇭🇺", "Icelandic 🇮🇸", "Indonesian 🇮🇩", "Italian 🇮🇹", "Japanese 🇯🇵", "Korean 🇰🇷", "Latin 🇮🇹", "Latvian 🇱🇻", "Lithuanian 🇱🇹", "Macedonian 🇲🇰", "Malay 🇲🇾", "Norwegian 🇳🇴", "Persian 🇮🇷", "Polish 🇵🇱", "Portuguese 🇵🇹", "Portuguese (Brazil) 🇧🇷", "Romanian 🇷🇴", "Russian 🇷🇺", "Slovak 🇸🇰", "Spanish 🇪🇸", "Swedish 🇸🇪", "Thai 🇹🇭", "Turkish 🇹🇷", "Ukrainian 🇺🇦", "Urdu 🇵🇰", "Vietnamese 🇻🇳"]
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
//    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 51
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            cell.textLabel?.text = (items[0])
            cell.textLabel?.font = UIFont(name:"PingFang SC", size:17)
            cell.textLabel?.contentMode = .scaleToFill
            cell.textLabel?.numberOfLines = 0
            
            return cell
        }
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            cell.textLabel?.text = (items[indexPath.row])
            cell.textLabel?.font = UIFont(name:"PingFang SC", size:16)
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
        customizeNavBar()
        
        tableView.clipsToBounds = true
        tableView.layer.shadowColor = UIColor.gray.cgColor;
        tableView.layer.shadowOffset = CGSize.zero
        tableView.layer.shadowOpacity = 1.0
        tableView.layer.shadowRadius = 2.0
        tableView.layer.masksToBounds = false
//        tableView.alpha = 0.7
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: "loadingCell")
        
        view.setGradientBackground(colorOne: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), colorTwo: UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1))
        
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
        
    }
    
}
