//
//  Apple.swift
//  snakegame
//
//  Created by Nik Rodionov on 23.06.2020.
//  Copyright © 2020 nrodionov. All rights reserved.
//

import SpriteKit

class Apple: SKShapeNode {
    convenience init(position: CGPoint) {
        self.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        
        fillColor = .red
        strokeColor = .red
        lineWidth = 5
        self.position = position 
        
        physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center:CGPoint(x: 5, y: 5))
        physicsBody?.categoryBitMask = CollisionCategories.Apple
    }
}
