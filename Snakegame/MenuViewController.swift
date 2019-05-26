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
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startBtn(_ sender: Any) {
        if let sb = self.storyboard {
            let gvc = sb.instantiateViewController(withIdentifier: "Game")
            present(gvc, animated: true)
        }
        
        
    }
    
    @IBAction func leaderboardBtn(_ sender: Any) {
        if let sb = self.storyboard {
            let gvc = sb.instantiateViewController(withIdentifier: "Leaderboard")
            present(gvc, animated: true)
        }
    }
}

