//
//  Snake.swift
//  snakegame
//
//  Created by Nik Rodionov on 23.06.2020.
//  Copyright © 2020 nrodionov. All rights reserved.
//

import SpriteKit

class Snake: SKShapeNode {
    private var body = [SnakeBodyPart]()
    private let moveSpeed: CGFloat = 125.0
    private var angle: CGFloat = 0.0
    
    convenience init(position: CGPoint) {
        self.init()
        
        let head = SnakeHead(position: position)
        body.append(head)
        
        addChild(head)
    }
    
    func addBodyPart() {
        let newBodyPart = SnakeBodyPart(position: body[0].position)
        body.append(newBodyPart)
        
        addChild(newBodyPart)
    }
    
    func moveClockWise() {
        angle += CGFloat.pi / 2
    }
    
    func moveCounterClockWise() {
        angle -= CGFloat.pi / 2
    }
    
    func move() {
        moveHead(body[0])
        
        for i in 1..<body.count {
            let previous = body[i - 1]
            let current = body[i]
            
            moveBodyPart(current, previous: previous)
        }
    }
    
    private func moveHead(_ head: SnakeBodyPart) {
        let dx = moveSpeed * sin(angle)
        let dy = moveSpeed * cos(angle)
        
        let nextPostion = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        
        let moveAction = SKAction.move(to: nextPostion, duration: 1.0)
        head.run(moveAction)
    }
    
    private func moveBodyPart(_ part: SnakeBodyPart, previous: SnakeBodyPart ) {
        let moveAction = SKAction.move(to: previous.position, duration: 0.1)
        
        part.run(moveAction)
    }
}
