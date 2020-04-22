//
//  ViewController.swift
//  InfiniteScrollingExample
//
//  Created by Robert Canton on 2018-03-12.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit
import Firebase

class LanguagesPopUp: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var isGone = false
    
    var targetCodePopUp : String?
    var textToTranslate : String?
    var translatedTextViewPopUp : String?
    
    let translationViewController = ViewController(nibName: "ViewController", bundle: nil)
    
    var tableView:UITableView!
    
    var fetchingMore = false
    var items = ["Spanish", "German", "French", "Swahili", "Chinese", "Hindi", "Italian", "Portuguese", "Croatian", "Swedish", "Japanese", "Romanian", "Polish", "Russian", "Norwegian", "Arabic"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        isGone = false
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: "loadingCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
//        let layoutGuide = view.safeAreaLayoutGuide
//        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return items.count
        } else if section == 1 && fetchingMore {
            return 1
        }
        return 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            cell.textLabel?.text = (items[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
            return cell
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            if !fetchingMore {
                beginBatchFetch()
            }
            
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        print("beginBatchFetch!")
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
//            let newItems = (self.items.count...self.items.count + 12).map { index in index }
//            self.items.append(contentsOf: newItems)
            
            self.items.append("Hi")
            self.items.append("Yo")
            self.items.append("Hola")

            self.fetchingMore = false
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected: \(indexPath.row)")
        
        if indexPath.row == 4 {
            self.targetCodePopUp = "zh-Hant"
        
            print("IN CHECK IN TABLE")
            
            translationViewController.targetCode = self.targetCodePopUp!

            isGone = true
//           translationViewController.translateText(detectedText: self.textToTranslate!)
            
            translateText(detectedText: self.textToTranslate!)
            
           print(translatedTextViewPopUp)
            translationViewController.translatedTextView.text = translatedTextViewPopUp
            
            
            self.view.removeFromSuperview()
        }
    }
    
    func translateText(detectedText: String) {
        
        var viewController = ViewController()
        
        guard !detectedText.isEmpty else {
            return
        }
        
        let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: viewController.textView.text, sourceLanguage: viewController.targetCodeOrigin, targetLanguage: viewController.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
            debugPrint(error?.localizedDescription)
            
            DispatchQueue.main.async {
                viewController.translatedTextView.text = translatedText
            }
            
        })
        task?.resume()
    }
}

