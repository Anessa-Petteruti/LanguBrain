//
//  ViewController.swift
//  LanguBrain
//
//  Created by Anessa Petteruti on 7/02/19.
//  Copyright © 2019 Anessa Petteruti. All rights reserved.
//

import UIKit
import Speech
import Firebase
import AVFoundation


class ViewController: UIViewController, SFSpeechRecognizerDelegate, AVSpeechSynthesizerDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    var alertCollection: GTAlertCollection!

    @IBOutlet weak var languagesView: UITableView!
    
    @IBOutlet weak var languagesOriginView: UITableView!
    
    var fetchingMore = false
    
    var items = ["Arabic", "Catalan", "Chinese (Simplified)", "Chinese (Traditional)", "Croatian", "Czech", "Danish", "Dutch", "English", "Finnish", "French", "German", "Greek", "Hebrew", "Hindi", "Hungarian", "Indonesian", "Italian", "Japanese", "Korean", "Malay", "Norwegian", "Polish", "Portuguese", "Portuguese (Brazil)", "Romanian", "Russian", "Slovak", "Spanish", "Swedish", "Thai", "Turkish", "Ukrainian", "Vietnamese"]
    
    var itemsTarget = ["Afrikaans", "Albanian", "Arabic", "Azerbaijani", "Belarusian", "Bulgarian", "Catalan", "Chinese (Simplified)", "Chinese (Traditional)", "Croatian", "Czech", "Danish", "Dutch", "English", "Estonian", "Filipino", "Finnish", "French", "Georgian", "German", "Greek", "Haitian Creole", "Hebrew", "Hindi", "Hungarian", "Icelandic", "Indonesian", "Italian", "Japanese", "Korean", "Latin", "Latvian", "Lithuanian", "Macedonian", "Malay", "Norwegian", "Persian", "Polish", "Portuguese", "Portuguese (Brazil)", "Romanian", "Russian", "Slovak", "Spanish", "Swedish", "Thai", "Turkish", "Ukrainian", "Urdu", "Vietnamese"]
    
    var flagImages: [UIImage] = []
    var flagImagesTarget: [UIImage] = []
    
    var targetCode = "en"
    var targetCodeOrigin = "en"
    
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var microphoneButton: UIButton!
	
    @IBOutlet weak var translateFromButton: UIButton!
    @IBOutlet weak var translateToButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    
    @IBOutlet weak var translatedTextView: UITextView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    private var speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    let synthesizer = AVSpeechSynthesizer()
    
    var finishedSpeaking = false
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordingDot: UIImageView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == languagesOriginView {
            if section == 0 {
                return items.count
            } else if section == 1 && fetchingMore {
                return 1
            }
        }
        else {
            if section == 0 {
                return itemsTarget.count
            } else if section == 1 && fetchingMore {
                return 1
            }
        }
        
        return 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        flagImages.append(UIImage(named: "saudi-arabia.png")!)
        flagImages.append(UIImage(named: "spain.png")!)
        flagImages.append(UIImage(named: "china.png")!)
        flagImages.append(UIImage(named: "china.png")!)
        flagImages.append(UIImage(named: "croatia.png")!)
        flagImages.append(UIImage(named: "czech-republic.png")!)
        flagImages.append(UIImage(named: "denmark.png")!)
        flagImages.append(UIImage(named: "netherlands.png")!)
        flagImages.append(UIImage(named: "united-states.png")!)
        flagImages.append(UIImage(named: "finland.png")!)
        flagImages.append(UIImage(named: "france.png")!)
        flagImages.append(UIImage(named: "germany.png")!)
        flagImages.append(UIImage(named: "greece.png")!)
        flagImages.append(UIImage(named: "israel.png")!)
        flagImages.append(UIImage(named: "india.png")!)
        flagImages.append(UIImage(named: "hungary.png")!)
        flagImages.append(UIImage(named: "indonesia.png")!)
        flagImages.append(UIImage(named: "italy.png")!)
        flagImages.append(UIImage(named: "japan.png")!)
        flagImages.append(UIImage(named: "south-korea.png")!)
        flagImages.append(UIImage(named: "malaysia.png")!)
        flagImages.append(UIImage(named: "norway.png")!)
        flagImages.append(UIImage(named: "republic-of-poland.png")!)
        flagImages.append(UIImage(named: "portugal.png")!)
        flagImages.append(UIImage(named: "brazil.png")!)
        flagImages.append(UIImage(named: "romania.png")!)
        flagImages.append(UIImage(named: "russia.png")!)
        flagImages.append(UIImage(named: "slovakia.png")!)
        flagImages.append(UIImage(named: "spain.png")!)
        flagImages.append(UIImage(named: "sweden.png")!)
        flagImages.append(UIImage(named: "thailand.png")!)
        flagImages.append(UIImage(named: "turkey.png")!)
        flagImages.append(UIImage(named: "ukraine.png")!)
        flagImages.append(UIImage(named: "vietnam.png")!)
        
        flagImagesTarget.append(UIImage(named: "south-africa.png")!)
        flagImagesTarget.append(UIImage(named: "albania.png")!)
        flagImagesTarget.append(UIImage(named: "saudi-arabia.png")!)
        flagImagesTarget.append(UIImage(named: "azerbaijan.png")!)
        flagImagesTarget.append(UIImage(named: "belarus.png")!)
        flagImagesTarget.append(UIImage(named: "bulgaria.png")!)
        flagImagesTarget.append(UIImage(named: "spain.png")!)
        flagImagesTarget.append(UIImage(named: "china.png")!)
        flagImagesTarget.append(UIImage(named: "china.png")!)
        flagImagesTarget.append(UIImage(named: "croatia.png")!)
        flagImagesTarget.append(UIImage(named: "czech-republic.png")!)
        flagImagesTarget.append(UIImage(named: "denmark.png")!)
        flagImagesTarget.append(UIImage(named: "netherlands.png")!)
        flagImagesTarget.append(UIImage(named: "united-states.png")!)
        flagImagesTarget.append(UIImage(named: "estonia.png")!)
        flagImagesTarget.append(UIImage(named: "philippines.png")!)
        flagImagesTarget.append(UIImage(named: "finland.png")!)
        flagImagesTarget.append(UIImage(named: "france.png")!)
        flagImagesTarget.append(UIImage(named: "georgia.png")!)
        flagImagesTarget.append(UIImage(named: "germany.png")!)
        flagImagesTarget.append(UIImage(named: "greece.png")!)
        flagImagesTarget.append(UIImage(named: "haiti.png")!)
        flagImagesTarget.append(UIImage(named: "israel.png")!)
        flagImagesTarget.append(UIImage(named: "india.png")!)
        flagImagesTarget.append(UIImage(named: "hungary.png")!)
        flagImagesTarget.append(UIImage(named: "iceland.png")!)
        flagImagesTarget.append(UIImage(named: "indonesia.png")!)
        flagImagesTarget.append(UIImage(named: "italy.png")!)
        flagImagesTarget.append(UIImage(named: "japan.png")!)
        flagImagesTarget.append(UIImage(named: "south-korea.png")!)
        flagImagesTarget.append(UIImage(named: "italy.png")!)
        flagImagesTarget.append(UIImage(named: "latvia.png")!)
        flagImagesTarget.append(UIImage(named: "lithuania.png")!)
        flagImagesTarget.append(UIImage(named: "republic-of-macedonia.png")!)
        flagImagesTarget.append(UIImage(named: "malaysia.png")!)
        flagImagesTarget.append(UIImage(named: "norway.png")!)
        flagImagesTarget.append(UIImage(named: "iran.png")!)
        flagImagesTarget.append(UIImage(named: "republic-of-poland.png")!)
        flagImagesTarget.append(UIImage(named: "portugal.png")!)
        flagImagesTarget.append(UIImage(named: "brazil.png")!)
        flagImagesTarget.append(UIImage(named: "romania.png")!)
        flagImagesTarget.append(UIImage(named: "russia.png")!)
        flagImagesTarget.append(UIImage(named: "slovakia.png")!)
        flagImagesTarget.append(UIImage(named: "spain.png")!)
        flagImagesTarget.append(UIImage(named: "sweden.png")!)
        flagImagesTarget.append(UIImage(named: "thailand.png")!)
        flagImagesTarget.append(UIImage(named: "turkey.png")!)
        flagImagesTarget.append(UIImage(named: "ukraine.png")!)
        flagImagesTarget.append(UIImage(named: "pakistan.png")!)
        flagImagesTarget.append(UIImage(named: "vietnam.png")!)
        
        
        
        if tableView == languagesOriginView {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
                cell.textLabel?.text = (items[indexPath.row])
                cell.textLabel?.font = UIFont(name:"PingFang SC", size:16)
                
                cell.imageView?.image = flagImages[indexPath.row]
                
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
                cell.spinner.startAnimating()
                return cell
            }
        }
        else {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
                cell.textLabel?.text = (itemsTarget[indexPath.row])
                cell.textLabel?.font = UIFont(name:"PingFang SC", size:16)
                
                cell.imageView?.image = flagImagesTarget[indexPath.row]
                
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
                cell.spinner.startAnimating()
                return cell
            }
        }
        

        
    }
    
    /* Updated for Swift 4 */
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            if !fetchingMore {
//                beginBatchFetch()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected: \(indexPath.row)")
        
        //***********TRANSLATE TO***************//
        if tableView == self.languagesView {
            
            if indexPath.row == 0 {
                
                if self.targetCodeOrigin != "af" {
                    
                    self.targetCode = "af"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Afrikaans 🇿🇦 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 1 {
                
                if self.targetCodeOrigin != "sq" {
                    
                    self.targetCode = "sq"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Albanian 🇦🇱 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 2 {
                
                if self.targetCodeOrigin != "ar" {
                    
                    self.targetCode = "ar"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Arabic 🇸🇦 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 3 {
                
                if self.targetCodeOrigin != "az" {
                    
                    self.targetCode = "az"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Azerbaijani 🇦🇿 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 4 {
                
                if self.targetCodeOrigin != "be" {
                    
                    self.targetCode = "be"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Belarusian 🇧🇾 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 5 {
                
                if self.targetCodeOrigin != "bg" {
                    
                    self.targetCode = "bg"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Bulgarian 🇧🇬 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 6 {
                
                if self.targetCodeOrigin != "ca" {
                    self.targetCode = "ca"
                    
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Catalan 🇪🇸 ↓", for: .normal)
                }

                
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 7 {
                if self.targetCodeOrigin != "zh-Hans" {
                    self.targetCode = "zh-Hans"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Chinese (Simplified) 🇨🇳 ↓", for: .normal)
                }

                
                
                
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
            }
            
            if indexPath.row == 8 {
                if self.targetCodeOrigin != "zh-Hant" {
                    self.targetCode = "zh-Hant"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Chinese (Traditional) 🇨🇳 ↓", for: .normal)
                }

                
                
                
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
            }
            
            if indexPath.row == 9 {
                if self.targetCodeOrigin != "hr" {
                    self.targetCode = "hr"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Croatian 🇭🇷 ↓", for: .normal)
                }

                
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
            }
            
            if indexPath.row == 10 {
                if self.targetCodeOrigin != "cs" {
                    self.targetCode = "cs"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Czech 🇨🇿 ↓", for: .normal)
                }

                
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
            }
            
            if indexPath.row == 11 {
                if self.targetCodeOrigin != "da" {
                    self.targetCode = "da"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Danish 🇩🇰 ↓", for: .normal)
                }

                
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
            }
            
            if indexPath.row == 12 {
                if self.targetCodeOrigin != "nl" {
                    self.targetCode = "nl"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Dutch 🇳🇱 ↓", for: .normal)
                }
                else {
                    
                    
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                    
                }
     
                
            }
            
            if indexPath.row == 13 {
                
                if self.targetCodeOrigin != "en" {
                
                    self.targetCode = "en"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: "en", completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("English 🇺🇸 ↓", for: .normal)
                }

                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
               
                
            }
            
            if indexPath.row == 14 {
                
                if self.targetCodeOrigin != "et" {
                    
                    self.targetCode = "et"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Estonian 🇪🇪 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 15 {
                
                if self.targetCodeOrigin != "tl" {
                    
                    self.targetCode = "tl"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Filipino 🇵🇭 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 16 {
                if self.targetCodeOrigin != "fi" {
                    self.targetCode = "fi"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Finnish 🇫🇮 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 17 {
                
                if self.targetCodeOrigin != "fr" {
                    self.targetCode = "fr"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("French 🇫🇷 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 18 {
                
                if self.targetCodeOrigin != "ka" {
                    
                    self.targetCode = "ka"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Georgian 🇬🇪 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 19 {
                
                if self.targetCodeOrigin != "de" {
                    self.targetCode = "de"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("German 🇩🇪 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 20 {
                if self.targetCodeOrigin != "el" {
                    self.targetCode = "el"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Greek 🇬🇷 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 21 {
                
                if self.targetCodeOrigin != "ht" {
                    
                    self.targetCode = "ht"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Haitian Creole 🇭🇹 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 22 {
                if self.targetCodeOrigin != "he" {
                    self.targetCode = "he"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Hebrew 🇮🇱 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 23 {
                if self.targetCodeOrigin != "hi" {
                    self.targetCode = "hi"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Hindi 🇮🇳 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 24 {
                if self.targetCodeOrigin != "hu" {
                    self.targetCode = "hu"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Hungarian 🇭🇺 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 25 {
                
                if self.targetCodeOrigin != "is" {
                    
                    self.targetCode = "is"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Icelandic 🇮🇸 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 26 {
                
                if self.targetCodeOrigin != "id" {
                    self.targetCode = "id"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Indonesian 🇲🇨 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 27 {
                if self.targetCodeOrigin != "it" {
                    self.targetCode = "it"
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Italian 🇮🇹 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 28 {
                if self.targetCodeOrigin != "ja" {
                    self.targetCode = "ja"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Japanese 🇯🇵 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 29 {
                if self.targetCodeOrigin != "ko" {
                    self.targetCode = "ko"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Korean 🇰🇷 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 30 {
                
                if self.targetCodeOrigin != "la" {
                    
                    self.targetCode = "la"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Latin 🇮🇹 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 31 {
                if self.targetCodeOrigin != "lv" {
                    self.targetCode = "lv"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Latvian 🇱🇻 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 32 {
                
                if self.targetCodeOrigin != "lt" {
                    
                    self.targetCode = "lt"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Lithuanian 🇱🇹 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 33 {
                
                if self.targetCodeOrigin != "mk" {
                    
                    self.targetCode = "mk"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Macedonian 🇲🇰 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 34 {
                if self.targetCodeOrigin != "ms" {
                    self.targetCode = "ms"
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Malay 🇲🇾 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 35 {
                if self.targetCodeOrigin != "nb" {
                    self.targetCode = "nb"
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Norwegian 🇳🇴 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 36 {
                
                if self.targetCodeOrigin != "fa" {
                    
                    self.targetCode = "fa"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Persian 🇮🇷 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 37 {
                if self.targetCodeOrigin != "pl" {
                    self.targetCode = "pl"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Polish 🇵🇱 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 38 {
                if self.targetCodeOrigin != "pt" {
                    self.targetCode = "pt"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Portuguese 🇵🇹 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 39 {
                if self.targetCodeOrigin != "pt-BR" {
                    self.targetCode = "pt-BR"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Portuguese (Brazil) 🇧🇷 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 40 {
                if self.targetCodeOrigin != "ro" {
                    self.targetCode = "ro"
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Romanian 🇷🇴 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 41 {
                if self.targetCodeOrigin != "ru" {
                    self.targetCode = "ru"
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Russian 🇷🇺 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
               
                
                
            }
            
            if indexPath.row == 42 {
                if self.targetCodeOrigin != "sk" {
                    self.targetCode = "sk"
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Slovak 🇸🇮 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 43 {
                if self.targetCodeOrigin != "es" {
                    self.targetCode = "es"
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: "es", completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Spanish 🇪🇸 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 44 {
                if self.targetCodeOrigin != "sv" {
                    self.targetCode = "sv"
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Swedish 🇸🇪 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 45 {
                if self.targetCodeOrigin != "th" {
                    self.targetCode = "th"
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Thai 🇹🇭 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 46 {
                if self.targetCodeOrigin != "tr" {
                    self.targetCode = "tr"
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Turkish 🇹🇷 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 47 {
                if self.targetCodeOrigin != "uk" {
                    self.targetCode = "uk"
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Ukrainian 🇺🇦 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }
            
            if indexPath.row == 48 {
                
                if self.targetCodeOrigin != "ur" {
                    
                    self.targetCode = "ur"
                    
                    //                translateText(detectedText: self.textView.text)
                    
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    self.languagesView.isHidden = true
                    self.languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Urdu 🇵🇰 ↓", for: .normal)
                }
                    
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
            }
            
            if indexPath.row == 49 {
                if self.targetCodeOrigin != "vi" {
                    self.targetCode = "vi"
                    
                    guard !self.textView.text.isEmpty else {
                        return
                    }
                    
                    let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
                        debugPrint(error?.localizedDescription)
                        
                        DispatchQueue.main.async {
                            self.translatedTextView.text = translatedText
                        }
                        
                    })
                    task?.resume()
                    
                    languagesView.isHidden = true
                    languagesOriginView.isHidden = true
                    translateFromButton.isHidden = false
                    
                    translateToButton.setTitle("Vietnamese 🇻🇳 ↓", for: .normal)
                }
                else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiffLangPopID") as! DiffLangPop
                    
                    self.addChildViewController(popOverVC)
                    
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParentViewController: self)
                }
                
                
                
            }

        }
        
        //***************TRANSLATE FROM*************//
        if tableView == self.languagesOriginView {
            
            if indexPath.row == 0 {

                self.targetCodeOrigin = "ar"


//                translateOriginText(detectedText: self.textView.text)


                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Arabic 🇸🇦 ↓", for: .normal)
            }
            if indexPath.row == 1 {
                
                self.targetCodeOrigin = "ca"
                
                
//                translateOriginText(detectedText: self.textView.text)
                
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Catalan 🇪🇸 ↓", for: .normal)
            }
            if indexPath.row == 2 {
                
                self.targetCodeOrigin = "zh-Hans"
                
                
//                translateOriginText(detectedText: self.textView.text)
                
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Chinese (Simplified) 🇨🇳 ↓", for: .normal)
            }
            if indexPath.row == 3 {
                
                self.targetCodeOrigin = "zh-Hant"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Chinese (Traditional) 🇨🇳 ↓", for: .normal)
            }
            if indexPath.row == 4 {
                
                self.targetCodeOrigin = "hr"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Croatian 🇭🇷 ↓", for: .normal)
            }
            if indexPath.row == 5 {
                
                self.targetCodeOrigin = "cs"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Czech 🇨🇿 ↓", for: .normal)
            }
            if indexPath.row == 6 {
                
                self.targetCodeOrigin = "da"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Danish 🇩🇰 ↓", for: .normal)
            }
            if indexPath.row == 7 {
                
                self.targetCodeOrigin = "nl"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Dutch 🇳🇱 ↓", for: .normal)
            }
            if indexPath.row == 8 {
                
//                if self.targetCode != "en" {
                    self.targetCodeOrigin = "en"

//                }
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("English 🇺🇸 ↓", for: .normal)
            }
            if indexPath.row == 9 {
                
                self.targetCodeOrigin = "fi"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Finnish 🇫🇮 ↓", for: .normal)
            }
            if indexPath.row == 10 {
                
                self.targetCodeOrigin = "fr"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("French 🇫🇷 ↓", for: .normal)
            }
            if indexPath.row == 11 {
                
                self.targetCodeOrigin = "de"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("German 🇩🇪 ↓", for: .normal)
            }
            if indexPath.row == 12 {
                
                self.targetCodeOrigin = "el"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Greek 🇬🇷 ↓", for: .normal)
            }
            if indexPath.row == 13 {
                
                self.targetCodeOrigin = "he"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Hebrew 🇮🇱 ↓", for: .normal)
            }
            if indexPath.row == 14 {
                
                self.targetCodeOrigin = "hi"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Hindi 🇮🇳 ↓", for: .normal)
            }
            if indexPath.row == 15 {
                
                self.targetCodeOrigin = "hu"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Hungarian 🇭🇺 ↓", for: .normal)
            }
            if indexPath.row == 16 {
                
                self.targetCodeOrigin = "id"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Indonesian 🇲🇨 ↓", for: .normal)
            }
            if indexPath.row == 17 {
                
                self.targetCodeOrigin = "it"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Italian 🇮🇹 ↓", for: .normal)
            }
            if indexPath.row == 18 {
                
                self.targetCodeOrigin = "ja"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Japanese 🇯🇵 ↓", for: .normal)
            }
            if indexPath.row == 19 {
                
                self.targetCodeOrigin = "ko"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Korean 🇰🇷 ↓", for: .normal)
            }
            if indexPath.row == 20 {
                
                self.targetCodeOrigin = "ms"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Malay 🇲🇾 ↓", for: .normal)
            }
            if indexPath.row == 21 {
                
                self.targetCodeOrigin = "nb"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Norwegian 🇳🇴 ↓", for: .normal)
            }
            if indexPath.row == 22 {
                
                self.targetCodeOrigin = "pl"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Polish 🇵🇱 ↓", for: .normal)
            }
            if indexPath.row == 23 {
                
                self.targetCodeOrigin = "pt"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Portuguese 🇵🇹 ↓", for: .normal)
            }
            if indexPath.row == 24 {
                
                self.targetCodeOrigin = "pt-BR"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Portuguese (Brazil) 🇧🇷 ↓", for: .normal)
            }
            if indexPath.row == 25 {
                
                self.targetCodeOrigin = "ro"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Romanian 🇷🇴 ↓", for: .normal)
            }
            if indexPath.row == 26 {
                
                self.targetCodeOrigin = "ru"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Russian 🇷🇺 ↓", for: .normal)
            }
            if indexPath.row == 27 {
                
                self.targetCodeOrigin = "sk"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Slovak 🇸🇮 ↓", for: .normal)
            }
            if indexPath.row == 28 {
                
                self.targetCodeOrigin = "es"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Spanish 🇪🇸 ↓", for: .normal)
            }
            if indexPath.row == 29 {
                
                self.targetCodeOrigin = "sv"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Swedish 🇸🇪 ↓", for: .normal)
            }
            if indexPath.row == 30 {
                
                self.targetCodeOrigin = "th"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Thai 🇹🇭 ↓", for: .normal)
            }
            if indexPath.row == 31 {
                
                self.targetCodeOrigin = "tr"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Turkish 🇹🇷 ↓", for: .normal)
            }
            if indexPath.row == 32 {
                
                self.targetCodeOrigin = "uk"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Ukrainian 🇺🇦 ↓", for: .normal)
            }
            if indexPath.row == 33 {
                
                self.targetCodeOrigin = "vi"
                
                self.languagesOriginView.isHidden = true
                self.languagesView.isHidden = true
                translateFromButton.isHidden = false
                
                translateFromButton.setTitle("Vietnamese 🇻🇳 ↓", for: .normal)
            }

        }
        
        print(self.targetCodeOrigin)
        print(self.targetCode)




        
    }
    
    @IBAction func translateButton(_ sender: Any) {
        
        guard !self.textView.text.isEmpty else {
            return
        }
        
        let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
            debugPrint(error?.localizedDescription)
            
            DispatchQueue.main.async {
                self.translatedTextView.text = translatedText
            }
            
        })
        task?.resume()
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        synthesizer.delegate = self
        textView.delegate = self
        translatedTextView.delegate = self

        textView.isScrollEnabled = true
        textView.isPagingEnabled = true
        textView.isUserInteractionEnabled = true
        textView.showsVerticalScrollIndicator = true
        
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 10)
        translatedTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 10)
        
        recordingLabel.isHidden = true
        recordingDot.isHidden = true

        sideMenus()
        
        customizeNavBar()
        
        alertCollection = GTAlertCollection(withHostViewController: self)

        
        
        view.setGradientBackground(colorOne: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), colorTwo: UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1))
        
//        translateFromButton.layer.borderColor = UIColor.black.cgColor
//        translateFromButton.layer.borderWidth = 1.3
//        translateFromButton.layer.cornerRadius = 20.0
        translateFromButton.clipsToBounds = true
//        translateFromButton.layer.shadowColor = UIColor.gray.cgColor;
//        translateFromButton.layer.shadowOffset = CGSize.zero
//        translateFromButton.layer.shadowOpacity = 1.0
//        translateFromButton.layer.shadowRadius = 0.8
        translateFromButton.layer.masksToBounds = false
        translateFromButton.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        
        
//        translateToButton.layer.borderColor = UIColor.black.cgColor
//        translateToButton.layer.borderWidth = 1.3
//        translateToButton.layer.cornerRadius = 20.0
        translateToButton.clipsToBounds = true
//        translateToButton.layer.shadowColor = UIColor.gray.cgColor;
//        translateToButton.layer.shadowOffset = CGSize.zero
//        translateToButton.layer.shadowOpacity = 1.0
//        translateToButton.layer.shadowRadius = 0.8
        translateToButton.layer.masksToBounds = false
        
        textView.layer.shadowColor = UIColor.gray.cgColor;
        textView.layer.shadowOffset = CGSize.zero
        textView.layer.shadowOpacity = 1.0
        textView.layer.shadowRadius = 2.0
//        textView.layer.cornerRadius = 1.0
        textView.layer.masksToBounds = true
        textView.alpha = 0.56

        
        translatedTextView.layer.shadowColor = UIColor.gray.cgColor;
        translatedTextView.layer.shadowOffset = CGSize.zero
        translatedTextView.layer.shadowOpacity = 1.0
        translatedTextView.layer.shadowRadius = 2.0
//        translatedTextView.layer.cornerRadius = 1.0
        translatedTextView.layer.masksToBounds = true
        translatedTextView.alpha = 0.56
        
        languagesView.layer.shadowColor = UIColor.black.cgColor
        languagesView.layer.shadowOpacity = 1
        languagesView.layer.shadowOffset = CGSize.zero
        languagesView.layer.shadowRadius = 10
        languagesView.layer.borderColor = UIColor.white.cgColor
        languagesView.layer.borderWidth = 2.0
        languagesView.layer.cornerRadius = 8.0
        languagesView.clipsToBounds = true
        
        languagesView.isHidden = true
        
        languagesView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        languagesView.register(loadingNib, forCellReuseIdentifier: "loadingCell")
        languagesView.delegate = self
        languagesView.dataSource = self
        
        view.addSubview(languagesView)
        languagesView.translatesAutoresizingMaskIntoConstraints = false
        
        languagesOriginView.layer.shadowColor = UIColor.black.cgColor
        languagesOriginView.layer.shadowOpacity = 1
        languagesOriginView.layer.shadowOffset = CGSize.zero
        languagesOriginView.layer.shadowRadius = 10
        languagesOriginView.layer.borderColor = UIColor.white.cgColor
        languagesOriginView.layer.borderWidth = 2.0
        languagesOriginView.layer.cornerRadius = 8.0
        languagesOriginView.clipsToBounds = true
        
        languagesOriginView.isHidden = true
        
        languagesOriginView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        let loadingNibOrigin = UINib(nibName: "LoadingCell", bundle: nil)
        languagesOriginView.register(loadingNibOrigin, forCellReuseIdentifier: "loadingCell")
        languagesOriginView.delegate = self
        languagesOriginView.dataSource = self
        
        view.addSubview(languagesOriginView)
        languagesOriginView.translatesAutoresizingMaskIntoConstraints = false

        
        microphoneButton.isEnabled = false
        
        speechRecognizer.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
        }
	}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	@IBAction func microphoneTapped(_ sender: AnyObject) {
        
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: self.targetCodeOrigin))!
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            audioEngine.inputNode?.removeTap(onBus: 0)
            microphoneButton.isEnabled = false
            microphoneButton.setImage(UIImage(named: "micOn"), for: .normal)
            recordingLabel.isHidden = true
            recordingDot.isHidden = true

        } else {
            startRecording()
            microphoneButton.setImage(UIImage(named: "micOff"), for: .normal)
            
            recordingLabel.isHidden = false
            recordingDot.isHidden = false
            
            self.recordingLabel.alpha = 1.0
            self.recordingDot.alpha = 1.0
            
            UIView.animate(withDuration: 0.6, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {
                self.recordingLabel.alpha = 0.0
                self.recordingDot.alpha = 0.0
                
            }, completion: nil)


        }
	}

    func startRecording() {
        
        if recognitionTask != nil {  //1
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()  //2
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()  //3
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }  //4
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        } //5
        
        recognitionRequest.shouldReportPartialResults = true  //6
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in  //7
            
            var isFinal = false  //8
            
            if result != nil {
                
                self.textView.text = result?.bestTranscription.formattedString  //9
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {  //10
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.microphoneButton.isEnabled = true
            }
        })
        
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        //ADDED THESE TWO LINES BELOW!!!!!!!!!!!!
        audioEngine.inputNode?.removeTap(onBus: 0)
        sleep(1)
        ////////////////////////////////////////
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()  //12
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        textView.text = "Say anything..."
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            microphoneButton.isEnabled = true
        } else {
            microphoneButton.isEnabled = false
        }
    }
    
    @IBAction func translateFromButton(_ sender: Any) {
        
        self.languagesOriginView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.languagesOriginView.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.languagesOriginView.alpha = 1.0
            self.languagesOriginView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.languagesOriginView.isHidden = false
            self.languagesView.isHidden = true
            self.translateFromButton.isHidden = true
        }
        
//        print(self.textView.text)

//        translateOriginText(detectedText: self.textView.text)
        
        
    }
    
    @IBAction func translateTextButton(_ sender: Any) {

        self.languagesView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.languagesView.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.languagesView.alpha = 1.0
            self.languagesView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.languagesView.isHidden = false
            self.languagesOriginView.isHidden = true
            self.translateFromButton.isHidden = true
        }
        
//            translateText(detectedText: self.textView.text)


    }
    
//    func translateOriginText(detectedText: String) {
//
//        guard !detectedText.isEmpty else {
//            return
//        }
//
//        print(self.targetCodeOrigin)
//
//        let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: detectedText, targetLanguage: self.targetCodeOrigin, completionHandler: { (translatedText: String?, error: Error?) in
//            debugPrint(error?.localizedDescription)
//
//            DispatchQueue.main.async {
//                self.textView.text = translatedText
//            }
//
//        })
//        task?.resume()
//    }
    
    
    func translateText(detectedText: String) {

        guard !detectedText.isEmpty else {
            return
        }

        let task = try? GoogleTranslate.sharedInstance.translateTextTask(text: self.textView.text, sourceLanguage: self.targetCodeOrigin, targetLanguage: self.targetCode, completionHandler: { (translatedText: String?, error: Error?) in
            debugPrint(error?.localizedDescription)
            
            DispatchQueue.main.async {
                self.translatedTextView.text = translatedText
            }
            
        })
        task?.resume()
    }
    
    @IBAction func switchLanguages(_ sender: Any) {
        
        if targetCode == "lv" || targetCode == "af" || targetCode == "sq" || targetCode == "az" || targetCode == "be" || targetCode == "bg" || targetCode == "et" || targetCode == "ft" || targetCode == "ka" || targetCode == "ht" || targetCode == "is" || targetCode == "la" || targetCode == "lt" || targetCode == "mk" || targetCode == "fa" || targetCode == "ur" {
            
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpSwitchID") as! PopUpSwitch
            
            self.addChildViewController(popOverVC)
            
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            
            translateToButton.setTitle("Select Language...", for: .normal)
            
        }
        else {
            var temp = "en"
            temp = self.targetCode
            
            self.targetCode = self.targetCodeOrigin
            
            self.targetCodeOrigin = temp
            
            if targetCodeOrigin == "ar" {
                translateFromButton.setTitle("Arabic 🇸🇦 ↓", for: .normal)
            }
            if targetCodeOrigin == "ca" {
                translateFromButton.setTitle("Catalan 🇪🇸 ↓", for: .normal)
            }
            if targetCodeOrigin == "zh-Hans" {
                translateFromButton.setTitle("Chinese (Simplified) 🇨🇳 ↓", for: .normal)
            }
            if targetCodeOrigin == "zh-Hant" {
                translateFromButton.setTitle("Chinese (Traditional) 🇨🇳 ↓", for: .normal)
            }
            if targetCodeOrigin == "hr" {
                translateFromButton.setTitle("Croatian 🇭🇷 ↓", for: .normal)
            }
            if targetCodeOrigin == "cs" {
                translateFromButton.setTitle("Czech 🇨🇿 ↓", for: .normal)
            }
            if targetCodeOrigin == "da" {
                translateFromButton.setTitle("Danish 🇩🇰 ↓", for: .normal)
            }
            if targetCodeOrigin == "nl" {
                translateFromButton.setTitle("Dutch 🇳🇱 ↓", for: .normal)
            }
            if targetCodeOrigin == "en" {
                translateFromButton.setTitle("English 🇺🇸 ↓", for: .normal)
            }
            if targetCodeOrigin == "fi" {
                translateFromButton.setTitle("Finnish 🇫🇮 ↓", for: .normal)
            }
            if targetCodeOrigin == "fr" {
                translateFromButton.setTitle("French 🇫🇷 ↓", for: .normal)
            }
            if targetCodeOrigin == "de" {
                translateFromButton.setTitle("German 🇩🇪 ↓", for: .normal)
            }
            if targetCodeOrigin == "el" {
                translateFromButton.setTitle("Greek 🇬🇷 ↓", for: .normal)
            }
            if targetCodeOrigin == "he" {
                translateFromButton.setTitle("Hebrew 🇮🇱 ↓", for: .normal)
            }
            if targetCodeOrigin == "hi" {
                translateFromButton.setTitle("Hindi 🇮🇳 ↓", for: .normal)
            }
            if targetCodeOrigin == "hu" {
                translateFromButton.setTitle("Hungarian 🇭🇺 ↓", for: .normal)
            }
            if targetCodeOrigin == "id" {
                translateFromButton.setTitle("Indonesian 🇮🇩 ↓", for: .normal)
            }
            if targetCodeOrigin == "it" {
                translateFromButton.setTitle("Italian 🇮🇹 ↓", for: .normal)
            }
            if targetCodeOrigin == "ja" {
                translateFromButton.setTitle("Japanese 🇯🇵 ↓", for: .normal)
            }
            if targetCodeOrigin == "ko" {
                translateFromButton.setTitle("Korean 🇰🇷 ↓", for: .normal)
            }
            if targetCodeOrigin == "ms" {
                translateFromButton.setTitle("Malay 🇲🇾 ↓", for: .normal)
            }
            if targetCodeOrigin == "nb" {
                translateFromButton.setTitle("Norwegian 🇳🇴 ↓", for: .normal)
            }
            if targetCodeOrigin == "pl" {
                translateFromButton.setTitle("Polish 🇵🇱 ↓", for: .normal)
            }
            if targetCodeOrigin == "pt" {
                translateFromButton.setTitle("Portuguese 🇵🇹 ↓", for: .normal)
            }
            if targetCodeOrigin == "pt-BR" {
                translateFromButton.setTitle("Portuguese (Brazil) 🇧🇷 ↓", for: .normal)
            }
            if targetCodeOrigin == "ro" {
                translateFromButton.setTitle("Romanian 🇹🇩 ↓", for: .normal)
            }
            if targetCodeOrigin == "ru" {
                translateFromButton.setTitle("Russian 🇷🇺 ↓", for: .normal)
            }
            if targetCodeOrigin == "sk" {
                translateFromButton.setTitle("Slovak 🇸🇰 ↓", for: .normal)
            }
            if targetCodeOrigin == "es" {
                translateFromButton.setTitle("Spanish 🇪🇸 ↓", for: .normal)
            }
            if targetCodeOrigin == "sv" {
                translateFromButton.setTitle("Swedish 🇸🇪 ↓", for: .normal)
            }
            if targetCodeOrigin == "th" {
                translateFromButton.setTitle("Thai 🇹🇭 ↓", for: .normal)
            }
            if targetCodeOrigin == "tr" {
                translateFromButton.setTitle("Turkish 🇹🇷 ↓", for: .normal)
            }
            if targetCodeOrigin == "uk" {
                translateFromButton.setTitle("Ukrainian 🇺🇦 ↓", for: .normal)
            }
            if targetCodeOrigin == "vi" {
                translateFromButton.setTitle("Vietnamese 🇻🇳 ↓", for: .normal)
            }
        }
            
        
        //**************TARGET*******************
        if targetCode == "ar" {
            translateToButton.setTitle("Arabic 🇸🇦 ↓", for: .normal)
        }
        if targetCode == "ca" {
            translateToButton.setTitle("Catalan 🇪🇸 ↓", for: .normal)
        }
        if targetCode == "zh-Hans" {
            translateToButton.setTitle("Chinese (Simplified) 🇨🇳 ↓", for: .normal)
        }
        if targetCode == "zh-Hant" {
            translateToButton.setTitle("Chinese (Traditional) 🇨🇳 ↓", for: .normal)
        }
        if targetCode == "hr" {
            translateToButton.setTitle("Croatian 🇭🇷 ↓", for: .normal)
        }
        if targetCode == "cs" {
            translateToButton.setTitle("Czech 🇨🇿 ↓", for: .normal)
        }
        if targetCode == "da" {
            translateToButton.setTitle("Danish 🇩🇰 ↓", for: .normal)
        }
        if targetCode == "nl" {
            translateToButton.setTitle("Dutch 🇳🇱 ↓", for: .normal)
        }
        if targetCode == "en" {
            translateToButton.setTitle("English 🇺🇸 ↓", for: .normal)
        }
        if targetCode == "fi" {
            translateToButton.setTitle("Finnish 🇫🇮 ↓", for: .normal)
        }
        if targetCode == "fr" {
            translateToButton.setTitle("French 🇫🇷 ↓", for: .normal)
        }
        if targetCode == "de" {
            translateToButton.setTitle("German 🇩🇪 ↓", for: .normal)
        }
        if targetCode == "el" {
            translateToButton.setTitle("Greek 🇬🇷 ↓", for: .normal)
        }
        if targetCode == "he" {
            translateToButton.setTitle("Hebrew 🇮🇱 ↓", for: .normal)
        }
        if targetCode == "hi" {
            translateToButton.setTitle("Hindi 🇮🇳 ↓", for: .normal)
        }
        if targetCode == "hu" {
            translateToButton.setTitle("Hungarian 🇭🇺 ↓", for: .normal)
        }
        if targetCode == "id" {
            translateToButton.setTitle("Indonesian 🇮🇩 ↓", for: .normal)
        }
        if targetCode == "it" {
            translateToButton.setTitle("Italian 🇮🇹 ↓", for: .normal)
        }
        if targetCode == "ja" {
            translateToButton.setTitle("Japanese 🇯🇵 ↓", for: .normal)
        }
        if targetCode == "ko" {
            translateToButton.setTitle("Korean 🇰🇷 ↓", for: .normal)
        }
        if targetCode == "ms" {
            translateToButton.setTitle("Malay 🇲🇾 ↓", for: .normal)
        }
        if targetCode == "nb" {
            translateToButton.setTitle("Norwegian 🇳🇴 ↓", for: .normal)
        }
        if targetCode == "pl" {
            translateToButton.setTitle("Polish 🇵🇱 ↓", for: .normal)
        }
        if targetCode == "pt" {
            translateToButton.setTitle("Portuguese 🇵🇹 ↓", for: .normal)
        }
        if targetCode == "pt-BR" {
            translateToButton.setTitle("Portuguese (Brazil) 🇧🇷 ↓", for: .normal)
        }
        if targetCode == "ro" {
            translateToButton.setTitle("Romanian 🇹🇩 ↓", for: .normal)
        }
        if targetCode == "ru" {
            translateToButton.setTitle("Russian 🇷🇺 ↓", for: .normal)
        }
        if targetCode == "sk" {
            translateToButton.setTitle("Slovak 🇸🇰 ↓", for: .normal)
        }
        if targetCode == "es" {
            translateToButton.setTitle("Spanish 🇪🇸 ↓", for: .normal)
        }
        if targetCode == "sv" {
            translateToButton.setTitle("Swedish 🇸🇪 ↓", for: .normal)
        }
        if targetCodeOrigin == "th" {
            translateFromButton.setTitle("Thai 🇹🇭 ↓", for: .normal)
        }
        if targetCodeOrigin == "tr" {
            translateFromButton.setTitle("Turkish 🇹🇷 ↓", for: .normal)
        }
        if targetCode == "uk" {
            translateToButton.setTitle("Ukrainian 🇺🇦 ↓", for: .normal)
        }
        if targetCode == "vi" {
            translateToButton.setTitle("Vietnamese 🇻🇳 ↓", for: .normal)
        }
        

    }
    
    @IBAction func audioButton(_ sender: Any) {
        
        if synthesizer.isSpeaking == false {
            
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, mode: AVAudioSessionModeDefault, options: .defaultToSpeaker)

                
                try AVAudioSession.sharedInstance().setActive(true, with: .notifyOthersOnDeactivation)
            } catch {
                print("audioSession properties weren't set because of an error.")
            }
            
            let utterance = AVSpeechUtterance(string: translatedTextView.text)
            utterance.voice = AVSpeechSynthesisVoice(language: self.targetCode)
            utterance.rate = 0.4
            synthesizer.speak(utterance)
            
            defer {
                disableAVSession()
            }
            
            audioButton.setImage(UIImage(named: "muted (2)"), for: .normal)

        }
            
        else {
            synthesizer.pauseSpeaking(at: .immediate)
            synthesizer.stopSpeaking(at: .immediate)
            audioEngine.inputNode?.removeTap(onBus: 0)
            audioButton.setImage(UIImage(named: "muted (1)"), for: .normal)

        }
        


    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        audioButton.setImage(UIImage(named: "muted (1)"), for: .normal)
    }
    
    
    private func disableAVSession() {
        do {
            try AVAudioSession.sharedInstance().setActive(false, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't disable.")
        }
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
    
    @IBAction func detectLanguage(_ sender: Any) {
        if textView.text != "" {
            // Present a "Please wait..." buttonless alert with an activity indicator.
            alertCollection.presentActivityAlert(withTitle: "Detect Language", message: "Please wait while text language is being detected...", activityIndicatorColor: UIColor.blue, showLargeIndicator: false) { (presented) in
                if presented {
            
                    TranslationManager.shared.detectLanguage(forText: self.textView.text) { (language) in
                        // Dismiss the buttonless alert.
                        self.alertCollection.dismissAlert(completion: nil)
                        
                        if var language = language {
                            if language == "ar" {
                                language = "Arabic"
                            }
                            if language == "ca" {
                                language = "Catalan"
                            }
                            if language == "zh-Hans" || language == "zh-CN" {
                                language = "Chinese (Simplified)"
                            }
                            if language == "zh-Hant" || language == "zh-TW" {
                                language = "Chinese (Traditional)"
                            }
                            if language == "hr" {
                                language = "Croatian"
                            }
                            if language == "cs" {
                                language = "Czech"
                            }
                            if language == "da" {
                                language = "Danish"
                            }
                            if language == "nl" {
                                language = "Dutch"
                            }
                            if language == "en" {
                                language = "English"
                            }
                            if language == "fi" {
                                language = "Finnish"
                            }
                            if language == "fr" {
                                language = "French"
                            }
                            if language == "de" {
                                language = "German"
                            }
                            if language == "el" {
                                language = "Greek"
                            }
                            if language == "he" || language == "iw" {
                                language = "Hebrew"
                            }
                            if language == "hi" {
                                language = "Hindi"
                            }
                            if language == "hu" {
                                language = "Hungarian"
                            }
                            if language == "id" {
                                language = "Indonesian"
                            }
                            if language == "it" {
                                language = "Italian"
                            }
                            if language == "ja" {
                                language = "Japanese"
                            }
                            if language == "ko" {
                                language = "Korean"
                            }
                            if language == "ms" {
                                language = "Malay"
                            }
                            if language == "nb" || language == "no" {
                                language = "Norwegian"
                            }
                            if language == "pl" {
                                language = "Polish"
                            }
                            if language == "pt" {
                                language = "Portuguese"
                            }
                            if language == "pt-BR" {
                                language = "Portuguese (Brazil)"
                            }
                            if language == "ro" {
                                language = "Romanian"
                            }
                            if language == "ru" {
                                language = "Russian"
                            }
                            if language == "sk" {
                                language = "Slovak"
                            }
                            if language == "es" {
                                language = "Spanish"
                            }
                            if language == "sv" {
                                language = "Swedish"
                            }
                            if language == "th" {
                                language = "Thai"
                            }
                            if language == "tr" {
                                language = "Turkish"
                            }
                            if language == "uk" {
                                language = "Ukrainian"
                            }
                            if language == "vi" {
                                language = "Vietnamese"
                            }
                            if language == "af" {
                                language = "Afrikaans"
                            }
                            if language == "sq" {
                                language = "Albanian"
                            }
                            if language == "az" {
                                language = "Azerbaijani"
                            }
                            if language == "be" {
                                language = "Belarusian"
                            }
                            if language == "bg" {
                                language = "Bulgarian"
                            }
                            if language == "et" {
                                language = "Estonian"
                            }
                            if language == "ft" {
                                language = "Filipino"
                            }
                            if language == "ka" {
                                language = "Georgian"
                            }
                            if language == "ht" {
                                language = "Haitian Creole"
                            }
                            if language == "is" {
                                language = "Icelandic"
                            }
                            if language == "la" {
                                language = "Latin"
                            }
                            if language == "lt" {
                                language = "Lithuanian"
                            }
                            if language == "mk" {
                                language = "Macedonian"
                            }
                            if language == "fa" {
                                language = "Persian"
                            }
                            if language == "ur" {
                                language = "Urdu"
                            }
                            // Present an alert with the detected language.
                            self.alertCollection.presentSingleButtonAlert(withTitle: "Detect Language", message: "The following language was detected:\n\n\(language)", buttonTitle: "OK", actionHandler: {
                                
                            })
                            
                        } else {
                            // Present an alert saying that an error occurred.
                            self.alertCollection.presentSingleButtonAlert(withTitle: "Detect Language", message: "Oops! It seems that something went wrong and language cannot be detected.", buttonTitle: "OK", actionHandler: {
                                
                            })
                        }
                    }
                    
                }
            }
            
        }
    }
    
    @IBAction func questionButton(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpID") as! PopUp
        
        self.addChildViewController(popOverVC)
        
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
}

