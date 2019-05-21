//
//  PauseViewController.swift
//  Snakegame
//
//  Created by Jacky on 2019-05-21.
//  Copyright © 2019 Jacky. All rights reserved.
//

import UIKit
import AVFoundation

class PauseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func continueBtn(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    
    @IBAction func restartBtn(_ sender: Any) {
        if let gvc = presentingViewController as? GameViewController {
            gvc.resetGame()
        }
        self.dismiss(animated: false)
        
    }

    
}

