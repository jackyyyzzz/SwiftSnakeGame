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
    var addATail = false
    var didSwiped = false
    var lastSwiped = ""
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        apple = self.childNode(withName: "Apple") as! SKSpriteNode
        apple.name = "Apple"
        
        snakeSections.append(self.childNode(withName: "Snake") as! SKSpriteNode)
        snakeSections[0].name = "Snake Head"

        initSwipeGestures(view)
        
        for _ in 0...1 {
            let newSnake = (snakeSections[0].copy() as! SKSpriteNode)
            newSnake.position = CGPoint(x: snakeSections.last!.position.x - 30, y: snakeSections.last!.position.y)

            newSnake.color = .green

            snakeSections.append(newSnake)
            self.addChild(newSnake)
        }
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.categoryBitMask = 7 // 0111
        border.isDynamic = false
        self.physicsBody = border
        border.accessibilityLabel = "Wall"
        
        snakeSections[0].physicsBody?.categoryBitMask = 1 // 0001
        snakeSections[0].physicsBody?.contactTestBitMask = 15 // 1111
        snakeSections[0].physicsBody?.collisionBitMask = 0
        snakeSections[0].physicsBody?.isDynamic = true
        
        apple.physicsBody?.categoryBitMask = 2
        apple.physicsBody?.contactTestBitMask = 1
        apple.physicsBody?.isDynamic = true
        
        view.showsPhysics = true
        print(snakeSections.count)
        
        
    }
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        
        if !hasContacted {
//            for i in snakeSections {
//                i.position = CGPoint(x: i.position.x - 2 , y: i.position.y)
//            }

        } else {
//            for i in snakeSections {
//                i.position = CGPoint(x: frame.maxX , y: i.position.y)
//            }
            snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: 640)

            hasContacted = false
        }
        
        if !addATail {
            return
            
        }
        else {
            hasEaten()
            addATail = false
        }
        
//        if didSwiped{
//            if lastSwiped == "right" {
//                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x + 30, y: snakeSections[0].position.y)
//            }
//            if lastSwiped == "left" {
//                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x - 30, y: snakeSections[0].position.y)
//                
//            }
//            if lastSwiped == "up" {
//                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y + 30)
//                
//            }
//            if lastSwiped == "down" {
//                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y - 30)
//            }
//        }
//        else {
//            if lastSwiped == "right" {
//                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x + 30, y: snakeSections[0].position.y)
//            }
//            if lastSwiped == "left" {
//                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x - 30, y: snakeSections[0].position.y)
//                
//            }
//            if lastSwiped == "up" {
//                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y + 30)
//                
//            }
//            if lastSwiped == "down" {
//                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y - 30)
//            }
//        }
        
 
        // use (320, 640) for snake head reappear
    
    }
    
    func didBegin(_ contact: SKPhysicsContact) {

        
        if (contact.bodyA.node!.name == "Apple" || contact.bodyB.node!.name == "Apple") {
            addATail = true
            print("apple eaten")
        }
        else if (contact.bodyA.accessibilityLabel == "Wall" || contact.bodyB.accessibilityLabel == "Wall") {
            hasContacted = true
            print("Walled")
        }
        
        
    }
    
    func hasEaten () {
        let newSnake = (snakeSections[0].copy() as! SKSpriteNode)
        newSnake.position = CGPoint(x: snakeSections.last!.position.x, y: snakeSections.last!.position.y)
        
        newSnake.color = .green
        apple.position = CGPoint(x:Int(arc4random()%320),y:Int(arc4random()%640))
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
        for i in (1...snakeSections.count - 1).reversed() {
            snakeSections[i].position = CGPoint(x: snakeSections[i-1].position.x, y: snakeSections[i-1].position.y)
        }
        
        snakeSections[0].position = CGPoint(x: snakeSections[0].position.x + 30, y: snakeSections[0].position.y)
        
        didSwiped = true
        lastSwiped = "right"
        print("right")
    }
    @objc func swipedLeft(sender: UISwipeGestureRecognizer) {
        for i in (1...snakeSections.count - 1).reversed() {
            snakeSections[i].position = CGPoint(x: snakeSections[i-1].position.x, y: snakeSections[i-1].position.y)
        }
        
        snakeSections[0].position = CGPoint(x: snakeSections[0].position.x - 30, y: snakeSections[0].position.y)
        
        didSwiped = true
        lastSwiped = "left"
        print("left")
    }
    @objc func swipedUp(sender: UISwipeGestureRecognizer) {
        for i in (1...snakeSections.count - 1).reversed() {
            snakeSections[i].position = CGPoint(x: snakeSections[i-1].position.x, y: snakeSections[i-1].position.y)
        }
        
        snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y + 30 )
        
        didSwiped = true
        lastSwiped = "up"
        print("up")
    }
    @objc func swipedDown(sender: UISwipeGestureRecognizer) {
        for i in (1...snakeSections.count - 1).reversed() {
            snakeSections[i].position = CGPoint(x: snakeSections[i-1].position.x, y: snakeSections[i-1].position.y)
        }
        
        snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y - 30 )
        
        didSwiped = true
        lastSwiped = "down"
        print("down")
    }
    
}
