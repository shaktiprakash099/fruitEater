//
//  MainMenuScene.swift
//  Fruit eater
//
//  Created by GLB-312-PC on 07/05/18.
//  Copyright © 2018 GLB-312-PC. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenuScene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches {
            let location = touch.location(in: self);
            if atPoint(location).name == "Start"{
                if let scene = GamePlaySceneClass(fileNamed: "GamePlayScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(2)));
                }

                
            }
        }
    }

}
