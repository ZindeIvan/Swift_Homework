//
//  SnakeHead.swift
//  snakegame
//
//  Created by Nik Rodionov on 23.06.2020.
//  Copyright © 2020 nrodionov. All rights reserved.
//

import SpriteKit

class SnakeHead: SnakeBodyPart {
    override init(position: CGPoint) {
        super.init(position: position)
        
        physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center:CGPoint(x: 5, y: 5))
        physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple | CollisionCategories.SnakeBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
