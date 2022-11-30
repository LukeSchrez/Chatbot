//
//  AccessViewController.swift
//  Chatbot
//
//  Created by Luke Schrezenmeier and Anthony Mardiros on 10/28/22.
//
//  SOURCES REFERENCED:
//  https://www.avanderlee.com/swift/dark-mode-support-ios/
//  https://www.appsloveworld.com/swift/100/100/how-do-i-keep-uiswitch-state-when-changing-viewcontrollers
//  https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/16253390#overview
//  https://stackoverflow.com/questions/46391986/how-can-i-save-switch-state#:~:text=You%20just%20need%20to%20save,before%20the%20switch%20would%20disappear.

import UIKit

/***********************************************************************************
 * Class AccessViewController:
 * This class functions as a seperate view controller for the accessibility screen.
 * The accessibility screen's main function is to provide light and dark mode
 * functionality for the user. Through the use of a seque, the user will be able to
 * enter this second screen at any time from the main screen. When the dark/light
 * mode slider is turned on, it will transition the entire app into dark mode and
 * when the switch is turned off, it will transition back to light mode
 ***********************************************************************************/

class AccessViewController: UIViewController {
    
    /***********************************************************************************
     * IBOutlets and IBActions:
     * ---------------------------------------------------------------------------------
     * darkModeSwitch: Allows us to control the functionality of the actual switch
     *
     * DarkModeButtonPressed: Changes the entire project into dark mode if the switch
     *                        is in the "on" position, if it is in the "off" position
     *                        it will switch to light mode.
     *
     * BackButtonPressed: Will return the user back to the main screen on press
     *
     * saveState: This will keep the current state of the switch as a bool so that
     *            when dismiss is called, it will have a copy of the last known state
     *            of the darkModeSwitch
     ***********************************************************************************/
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    @IBAction func DarkModeButtonPressed(_ sender: UISwitch) {
        if(sender.isOn){
            //Using the window method transforms the entire project into dark or light mode
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
    
    //If the back button is pressed, dismiss the accessibility screen and return to home
    @IBAction func BackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    //This allows us to save the dark mode switch state so that it retains its state when switching views
    override func viewDidLoad() {
        super.viewDidLoad()
        darkModeSwitch.isOn =  UserDefaults.standard.bool(forKey: "darkModeState")
    }
    
    //Save the current state of the UISwitch into a key to load later when the view is accessed again
    @IBAction func saveState(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "darkModeState")
    }

}
