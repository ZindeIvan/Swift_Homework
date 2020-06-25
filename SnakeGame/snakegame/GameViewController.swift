//
//  GameViewController.swift
//  snakegame
//
//  Created by Nik Rodionov on 23.06.2020.
//  Copyright © 2020 nrodionov. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view UIView -> view SKView
        
        // self.view as? SKView -> SKView?
        let v1 = self.view as? SKView        
        if let skView = v1 { 
            let scene = GameScene()
            scene.scaleMode = .resizeFill
            
            skView.presentScene(scene)
            
            skView.showsPhysics = true
            skView.ignoresSiblingOrder = true
            skView.showsFPS = true
            skView.showsNodeCount = true
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
}
