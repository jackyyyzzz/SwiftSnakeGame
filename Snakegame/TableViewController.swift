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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstName?.text = UserDefaults().string(forKey: "firstHigh") ?? "Player"
        secondName?.text = UserDefaults().string(forKey: "secondHigh") ?? "Player"
        thirdName?.text = UserDefaults().string(forKey: "thirdHigh") ?? "Player"
        
        firstScore?.text = String(UserDefaults().integer(forKey: "firstHighScore"))
        secondScore?.text = String(UserDefaults().integer(forKey: "secondHighScore"))
        thirdScore?.text = String(UserDefaults().integer(forKey: "thirdHighScore"))
        
    }
    
    
    
    @IBAction func closeBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
