//
//  TableViewController.swift
//  Snakegame
//
//  Created by Jacky on 2019-05-26.
//  Copyright © 2019 Jacky. All rights reserved.
//

import UIKit
import AVFoundation

class ScoreViewController: UIViewController {
    
    @IBOutlet var firstName: UILabel!
    @IBOutlet var secondName: UILabel!
    @IBOutlet var thirdName: UILabel!
    
    @IBOutlet var firstScore: UILabel!
    @IBOutlet var secondScore: UILabel!
    @IBOutlet var thirdScore: UILabel!
    
    @IBOutlet var newHighScoreWinner: UIView!
    @IBOutlet var newWinnerInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstName?.text = UserDefaults().string(forKey: "firstHigh") ?? "Player"
        secondName?.text = UserDefaults().string(forKey: "secondHigh") ?? "Player"
        thirdName?.text = UserDefaults().string(forKey: "thirdHigh") ?? "Player"
        
        firstScore?.text = String(UserDefaults().integer(forKey: "firstHighScore"))
        secondScore?.text = String(UserDefaults().integer(forKey: "secondHighScore"))
        thirdScore?.text = String(UserDefaults().integer(forKey: "thirdHighScore"))
        
        if firstName?.text == "You" {
            newHighScoreWinner.isHidden = false
        }
        else if secondName?.text == "You" {
            newHighScoreWinner.isHidden = false
        }
        else if thirdName?.text == "You" {
            newHighScoreWinner.isHidden = false
        }
    }
    
    
    
    @IBAction func closeBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newWinnerTxt(_ sender: UITextField) {
        if firstName?.text == "You" {
            firstName?.text = newWinnerInput.text
            UserDefaults.standard.setValue(firstName.text, forKey: "firstHigh")
        }
        else if secondName?.text == "You" {
            secondName?.text = newWinnerInput.text
            UserDefaults.standard.setValue(secondName.text, forKey: "secondHigh")
        }
        else if thirdName?.text == "You" {
            thirdName?.text = newWinnerInput.text
            UserDefaults.standard.setValue(thirdName.text, forKey: "thirdHigh")
        }
        newHighScoreWinner.isHidden = true
        UserDefaults.standard.synchronize()
        sender.resignFirstResponder()
    }
}


//make newHighScoreWinner able to input into new winner
