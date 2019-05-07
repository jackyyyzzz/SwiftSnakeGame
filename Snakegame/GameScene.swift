//
//  GameScene.swift
//  Snakegame
//
//  Created by Jacky on 2019-05-05.
//  Copyright © 2019 Jacky. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    var apple = SKSpriteNode()
    var snakeSections: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        apple = self.childNode(withName: "Apple") as! SKSpriteNode
        snakeSections.append(self.childNode(withName: "Snake") as! SKSpriteNode)

        initSwipeGestures(view)
        
        for _ in 0...5 {
            let newSnake = (snakeSections[0].copy() as! SKSpriteNode)
            newSnake.position = CGPoint(x: snakeSections[0].position.x, y: snakeSections.last!.position.y - 50)
            
            newSnake.color = .green
            
            snakeSections.append(newSnake)
            self.addChild(newSnake)
        }
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.categoryBitMask = 2
        border.isDynamic = false
        border.affectedByGravity = false
        self.physicsBody = border
        
        snakeSections[0].physicsBody?.categoryBitMask = 4
        snakeSections[0].physicsBody?.contactTestBitMask = 2
        snakeSections[0].physicsBody?.collisionBitMask = 0
        snakeSections[0].physicsBody?.isDynamic = true
        
        view.showsPhysics = true
    }
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        snakeSections[0].position = CGPoint(x: snakeSections[0].position.x + 1, y: snakeSections[0].position.y)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("collision detected")
    }
    
    func initSwipeGestures(_ view: SKView) {
        let swipeRight : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        let swipeLeft : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        let swipeUp : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedUp))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        let swipeDown : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedDown))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipedRight(sender: UISwipeGestureRecognizer) {
        
    }
    @objc func swipedLeft(sender: UISwipeGestureRecognizer) {
    }
    @objc func swipedUp(sender: UISwipeGestureRecognizer) {
    }
    @objc func swipedDown(sender: UISwipeGestureRecognizer) {
    }
    
}
