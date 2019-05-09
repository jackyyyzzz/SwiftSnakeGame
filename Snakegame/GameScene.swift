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
    
    var hasContacted = false
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        apple = self.childNode(withName: "Apple") as! SKSpriteNode
        apple.name = "Apple"
        
        snakeSections.append(self.childNode(withName: "Snake") as! SKSpriteNode)

        initSwipeGestures(view)
        
//        for _ in 0...5 {
//            let newSnake = (snakeSections[0].copy() as! SKSpriteNode)
//            newSnake.position = CGPoint(x: snakeSections[0].position.x, y: snakeSections.last!.position.y - 50)
//
//            newSnake.color = .green
//
//            snakeSections.append(newSnake)
//            self.addChild(newSnake)
//        }
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.categoryBitMask = 7 // 0111
        border.isDynamic = false
        self.physicsBody = border
        
        snakeSections[0].physicsBody?.categoryBitMask = 1 // 0001
        snakeSections[0].physicsBody?.contactTestBitMask = 15 // 1111
        snakeSections[0].physicsBody?.collisionBitMask = 0
        snakeSections[0].physicsBody?.isDynamic = true
        
        apple.physicsBody?.categoryBitMask = 2
        apple.physicsBody?.contactTestBitMask = 1
        apple.physicsBody?.isDynamic = true
        
        view.showsPhysics = true
        print(snakeSections[0].position)
    }
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if !hasContacted {
//            for i in snakeSections {
//                i.position = CGPoint(x: i.position.x - 2 , y: i.position.y)
//            }
            snakeSections[0].position = CGPoint(x: snakeSections[0].position.x - 2, y: snakeSections[0].position.y)
            
        } else {
//            for i in snakeSections {
//                i.position = CGPoint(x: frame.maxX , y: i.position.y)
//            }
            hasEaten()
            snakeSections[0].position = CGPoint(x: frame.maxX, y: 123)

            hasContacted = false
        }
        
    
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("collision detected")
        
        if (contact.bodyA.node!.name == "Apple" || contact.bodyB.node!.name == "Apple") {

            hasContacted = true
        }
        
    }
    
    func hasEaten () {
        let newSnake = (snakeSections[0].copy() as! SKSpriteNode)
        newSnake.position = CGPoint(x: snakeSections.last!.position.x, y: snakeSections.last!.position.y - 50)
        
        newSnake.color = .green
        apple.position = CGPoint (x: 123, y: 123)
        snakeSections.append(newSnake)
        self.addChild(newSnake)
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
