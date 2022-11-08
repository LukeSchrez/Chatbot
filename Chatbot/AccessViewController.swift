//
//  AccessViewController.swift
//  Chatbot
//
//  Created by Luke Schrezenmeier on 10/28/22.
//
//  SOURCES REFERENCED:
//  https://www.avanderlee.com/swift/dark-mode-support-ios/
//  https://www.appsloveworld.com/swift/100/100/how-do-i-keep-uiswitch-state-when-changing-viewcontrollers

import UIKit

class AccessViewController: UIViewController {
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    @IBAction func DarkModeButtonPressed(_ sender: UISwitch) {
        if(sender.isOn){
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
            
        }
        else{
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }

        }
        
    }
    
    @IBAction func BackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkModeSwitch.isOn =  UserDefaults.standard.bool(forKey: "darkModeState")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveState(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "darkModeState")
    }

}
