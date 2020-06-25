//
//  GameScene.swift
//  snakegame
//
//  Created by Nik Rodionov on 23.06.2020.
//  Copyright © 2020 nrodionov. All rights reserved.
//

import SpriteKit
import GameplayKit

struct CollisionCategories {
    static let Snake: UInt32 = 1
    static let SnakeHead: UInt32 = 1 << 1
    static let Apple: UInt32 = 1 << 2
    static let EdgeBody: UInt32 = 1 << 3    
}

class GameScene: SKScene {
    private let counterClockWiseButtonName = "counterClockwiseButton"
    private let clockWiseButtonName = "clockwiseButton"
    private var snake: Snake!
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.allowsRotation = false
        
        let counterClockwisePosition = CGPoint(x: frame.minX + 30, y: frame.minY + 30)
        let clockwisePosition = CGPoint(x: frame.maxX - 80, y: frame.minY + 30)
        
        addRotationButton(name: counterClockWiseButtonName, position: counterClockwisePosition)
        addRotationButton(name: clockWiseButtonName, position: clockwisePosition)
        
        snake = Snake(position: CGPoint(x: frame.midX, y: frame.midY))
        addChild(snake)
        createApple()
        
        physicsWorld.contactDelegate = self
        
        physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
    }
    
    private func createApple() {
        let randX = CGFloat.random(in: 0..<frame.maxX - 5)
        let randY = CGFloat.random(in: 0..<frame.maxY - 5)
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        
        addChild(apple)
    }
    
    private func addRotationButton(name: String, position: CGPoint) {
        let button = SKShapeNode()
        button.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        
        button.position = position
        button.fillColor = .gray
        button.strokeColor = .gray
        button.lineWidth = 10
        button.name = name
        addChild(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchedNode = atPoint(touchLocation) as? SKShapeNode else { continue }
            
            if touchedNode.name == clockWiseButtonName {
                touchedNode.fillColor = .green
                snake.moveClockWise()
            }
            else if touchedNode.name == counterClockWiseButtonName {
                touchedNode.fillColor = .green
                snake.moveCounterClockWise()
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchedNode = atPoint(touchLocation) as? SKShapeNode else { continue }
            
            if touchedNode.name == clockWiseButtonName {
                touchedNode.fillColor = .gray
            }
            else if touchedNode.name == counterClockWiseButtonName {
                touchedNode.fillColor = .gray
            }
        }
        
        // * SKLabelNode - для отображения текста
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        snake.move()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bytes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let collisioObject = bytes ^ CollisionCategories.SnakeHead
        
        switch collisioObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake.addBodyPart()
            apple?.removeFromParent()
            createApple()
        default:
            break
        }
    }
}
