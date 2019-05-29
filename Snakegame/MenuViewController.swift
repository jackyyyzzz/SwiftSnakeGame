//
//  MenuViewController.swift
//  Snakegame
//
//  Created by Jacky on 2019-05-20.
//  Copyright © 2019 Jacky. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    @IBOutlet var playerNameEntry: UIView!
    
    @IBOutlet var newPlayerInput: UITextField!
    
    @IBOutlet var currentPlayerNameLbl: UILabel!
    
    @IBOutlet var newPlayerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPlayerNameLbl.text = UserDefaults().string(forKey: "currentPlayer") ?? "Player Name"
    }
    
    @IBAction func startBtn(_ sender: Any) {
        if let sb = self.storyboard {
            let gvc = sb.instantiateViewController(withIdentifier: "Game")
            present(gvc, animated: true)
        }
    }
    
    @IBAction func newplayerInput(_ sender: UITextField) {
        UserDefaults.standard.setValue(newPlayerInput.text, forKey: "currentPlayer")
        currentPlayerNameLbl.text = newPlayerInput.text
        UserDefaults.standard.synchronize()
        playerNameEntry.isHidden = true
        newPlayerBtn.isHidden = false
        sender.resignFirstResponder()
    }
    

    @IBAction func newPlayerBtn(_ sender: Any) {
        playerNameEntry.isHidden = false
        newPlayerBtn.isHidden = true
    }
    
    
    @IBAction func leaderboardBtn(_ sender: Any) {
        if let sb = self.storyboard {
            let gvc = sb.instantiateViewController(withIdentifier: "Leaderboard")
            present(gvc, animated: true)
        }
    }
}


// make leaderboard list to 10 rolls.
// try to make check highscore func in a for loop fasion, or simpler


