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
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        apple = self.childNode(withName: "Apple") as! SKSpriteNode
        apple.name = "Apple"
        
        snakeSections.append(self.childNode(withName: "Snake") as! SKSpriteNode)
        snakeSections[0].name = "Snake Head"

        initSwipeGestures(view)
        
        for _ in 0...5 {
            let newSnake = (snakeSections[0].copy() as! SKSpriteNode)
            newSnake.position = CGPoint(x: snakeSections.last!.position.x - 1, y: snakeSections.last!.position.y)

            newSnake.color = .green

            snakeSections.append(newSnake)
            self.addChild(newSnake)
        }
        

        
        let border = SKPhysicsBody(edgeLoopFrom: gameFrame)
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
            switch lastSwiped {
            case "right":
                tailFollow()
                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x + 3, y: snakeSections[0].position.y)
            case "left":
                tailFollow()
                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x - 3, y: snakeSections[0].position.y)
            case "up":
                tailFollow()
                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y + 3)
            case "down":
                tailFollow()
                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y - 3)
            default:
                tailFollow()
            }
        }
        else {
            //when contact wall, appear on the other side of the screen
            switch lastSwiped {
            case "right":
                tailFollow()
                snakeSections[0].position = CGPoint(x: gameFrame.minX + 30, y: snakeSections[0].position.y)

            case "left":
                tailFollow()
                snakeSections[0].position = CGPoint(x: gameFrame.maxX - 30, y: snakeSections[0].position.y)

            case "up":
                tailFollow()
                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: gameFrame.minY + 30)

            case "down":
                tailFollow()
                snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: gameFrame.maxY - 30)
            default:
                tailFollow()
            }
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
        else if (contact.bodyA.accessibilityLabel == "Wall" || contact.bodyB.accessibilityLabel == "Wall") {
            hasContacted = true
            print("Walled")
            print(snakeSections[0])
        }
    }
    
    func hasEaten () {
        let newSnake = (snakeSections[0].copy() as! SKSpriteNode)
        newSnake.position = CGPoint(x: snakeSections.last!.position.x, y: snakeSections.last!.position.y)
        
        newSnake.color = .green
        apple.position = CGPoint(x:Int(arc4random()%250),y:Int(arc4random()%480))
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
        tailFollow()
        
        snakeSections[0].position = CGPoint(x: snakeSections[0].position.x + 1, y: snakeSections[0].position.y)
        
        lastSwiped = "right"
        print("right")
    }
    @objc func swipedLeft(sender: UISwipeGestureRecognizer) {
        tailFollow()
        
        snakeSections[0].position = CGPoint(x: snakeSections[0].position.x - 1, y: snakeSections[0].position.y)
        
        lastSwiped = "left"
        print("left")
    }
    @objc func swipedUp(sender: UISwipeGestureRecognizer) {
        tailFollow()
        
        snakeSections[0].position = CGPoint(x: snakeSections[0].position.x, y: snakeSections[0].position.y + 1)
        
        lastSwiped = "up"
        print("up")
    }
    @objc func swipedDown(sender: UISwipeGestureRecognizer) {
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
    
}
