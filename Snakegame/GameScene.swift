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
    let gameFrame = CGRect(x: -250, y: -480, width: 500, height: 980)
    
    var hasContacted = false
    var addATail = false
    var lastSwiped = ""
    
    var previousTime: Double = 0
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        apple = self.childNode(withName: "Apple") as! SKSpriteNode
        apple.physicsBody?.categoryBitMask = 2
        apple.physicsBody?.contactTestBitMask = 1
        apple.physicsBody?.isDynamic = true
        apple.name = "Apple"
        
        newSnake()

        initSwipeGestures(view)
        
        
        let border = SKPhysicsBody(edgeLoopFrom: gameFrame)
        border.categoryBitMask = 7 // 0111
        border.isDynamic = false
        self.physicsBody = border
        self.physicsBody?.node?.name = "Wall"
        
        view.showsPhysics = true
        print(snakeSections.count)
    }
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        let speed = 150.0
        let delta = currentTime - previousTime
        previousTime = currentTime
        
        if !hasContacted {
            switch lastSwiped {
            case "right":
                tailFollow()
                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x + CGFloat(speed * delta), y: snakeSections[0].position.y)
            case "left":
                tailFollow()
                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x - CGFloat(speed * delta), y: snakeSections[0].position.y)
            case "up":
                tailFollow()
                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y + CGFloat(speed * delta))
            case "down":
                tailFollow()
                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y - CGFloat(speed * delta))
            default:
                tailFollow()
            }
        }
        else {
            //when contact wall/itself, terminates game and restart

            restartGame()
            
            
            hasContacted = false
        }
        
        if !addATail {
            return
        }
        else {
            hasEaten()
            addATail = false
        }
        

        
 
        // use (320, 640) for snake head reappear
    
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.node!.name == "Apple" || contact.bodyB.node!.name == "Apple") {
            addATail = true
            print("apple eaten")
        }
        else if (contact.bodyA.node!.name == "Wall" || contact.bodyB.node!.name == "Wall") {
            if (contact.bodyA.node!.name == "Snake Head" || contact.bodyB.node!.name == "Snake Head") {
                hasContacted = true
                print("Walled")
            }
        }
        else if (contact.bodyA.node!.name == "Snake Tail" && contact.bodyB.node!.name == "Snake Tail") {
            if (contact.bodyB.node!.name == "Snake Head" && contact.bodyA.node!.name == "Snake Head") {
                hasContacted = true
                print("Ate itself")
            }
        }
    }
    
    func hasEaten () {
        let newSnake = (snakeSections[0].copy() as! SKSpriteNode)
        newSnake.name = "Snake Tail"
        newSnake.position = CGPoint(x: snakeSections.last!.position.x, y: snakeSections.last!.position.y)

        
        newSnake.color = .green
        
        let xRand = CGFloat.random(in: -250...250)
        let yRand = CGFloat.random(in: -480...480)
        apple.position = CGPoint(x: xRand, y: yRand)
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
        if lastSwiped == "left" {
            return
        }
        
        tailFollow()
        snakeSections[0].position = CGPoint(x: snakeSections[0].position.x + 1, y: snakeSections[0].position.y)
        lastSwiped = "right"
        print("right")
    }
    @objc func swipedLeft(sender: UISwipeGestureRecognizer) {
        if lastSwiped == "right" {
            return
        }
        
        tailFollow()
        snakeSections[0].position = CGPoint(x: snakeSections[0].position.x - 1, y: snakeSections[0].position.y)
        
        lastSwiped = "left"
        print("left")
    }
    @objc func swipedUp(sender: UISwipeGestureRecognizer) {
        if lastSwiped == "down" {
            return
        }
        
        tailFollow()
        snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y + 1)
        
        lastSwiped = "up"
        print("up")
    }
    @objc func swipedDown(sender: UISwipeGestureRecognizer) {
        if lastSwiped == "up" {
            return
        }
        
        tailFollow()
        snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y - 1 )

        lastSwiped = "down"
        print("down")
    }
    
    
    func tailFollow() {
        for i in (1...snakeSections.count - 1).reversed() {
            snakeSections[i].position = CGPoint(x: snakeSections[i-1].position.x, y: snakeSections[i-1].position.y)
        }
    }
    
    func restartGame() {

        self.removeChildren(in: snakeSections)
        lastSwiped = ""
        newSnake()
        apple.position = CGPoint(x: 0, y: 0)
    }
    
    func newSnake() {
        snakeSections = []
        snakeSections.append(self.childNode(withName: "Snake")!.copy() as! SKSpriteNode)
        self.addChild(snakeSections[0])
        
        for _ in 0...5 {
            let newSnake = (snakeSections[0].copy() as! SKSpriteNode)
            newSnake.position = CGPoint(x: snakeSections.last!.position.x - 1, y: snakeSections.last!.position.y)
            
            newSnake.color = .green
            
            snakeSections.append(newSnake)
            self.addChild(newSnake)
        }
        
        snakeSections[0].name = "Snake Head"
        snakeSections[0].color = .white
        snakeSections[0].physicsBody?.categoryBitMask = 1 // 0001
        snakeSections[0].physicsBody?.contactTestBitMask = 15 // 1111
        snakeSections[0].physicsBody?.isDynamic = true
    }
}
