//
//  GameViewController.swift
//  Snakegame
//
//  Created by Jacky on 2019-05-05.
//  Copyright © 2019 Jacky. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet var pauseBtn: UIButton!
    @IBOutlet var continueBtn: UIButton!
    @IBOutlet var restartBtn: UIButton!
    @IBOutlet var leaderboardBtn: UIButton!
    
    @IBOutlet var pauseMenuPopUp: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }

        
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    func resetGame() {
        viewDidLoad()
    }
    
    func pauseGame() {
        let skView = self.view as! SKView
        skView.scene?.isPaused = true
    }
    
    func unpauseGame() {
        let skView = self.view as! SKView
        skView.scene?.isPaused = false
    }
    
    func pauseMenu() {
        pauseGame()
        pauseBtn.isHidden = true
        pauseMenuPopUp.self.isHidden = false
        continueBtn.isHidden = false
        restartBtn.isHidden = false
    }

    @IBAction func pauseBtn(_ sender: Any) {
        pauseMenu()

    }
    
    @IBAction func continueBtn(_ sender: Any) {
        unpauseGame()
        pauseMenuPopUp.self.isHidden = true
        continueBtn.isHidden = true
        restartBtn.isHidden = true
        pauseBtn.isHidden = false
    }
    
    
    @IBAction func restartBtn(_ sender: Any) {
        unpauseGame()
        resetGame()
        pauseMenuPopUp.self.isHidden = true
        restartBtn.isHidden = true
        continueBtn.isHidden = true
        pauseBtn.isHidden = false
        
    }
    
    @IBAction func leaderboardBtn(_ sender: Any) {
        pauseGame()
        pauseMenu()
        pauseBtn.isHidden = true
        if let sb = self.storyboard {
            let gvc = sb.instantiateViewController(withIdentifier: "Leaderboard")
            present(gvc, animated: true)
        }
    }
    
    
}
