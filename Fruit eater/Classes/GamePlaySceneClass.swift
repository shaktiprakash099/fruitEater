//
//  GamePlaySceneClass.swift
//  Fruit eater
//
//  Created by GLB-312-PC on 07/05/18.
//  Copyright © 2018 GLB-312-PC. All rights reserved.
//

import UIKit
import SpriteKit

class GamePlaySceneClass: SKScene,SKPhysicsContactDelegate {
    
    private var player : Player?
    private var center = CGFloat();
    private var canMove = false,moveLeft = false;
    private var itemController = ItemController();
    private var scorelabel : SKLabelNode?
    private var score = 0;
    override func didMove(to view: SKView) {
        initilaizeGame()
    }
    override func update(_ currentTime: TimeInterval) {
        managePlayer()

        
    }
        let mynode = SKSpriteNode(imageNamed: "Fruit1")
    private func initilaizeGame(){
        physicsWorld.contactDelegate = self;
        player = childNode(withName: "Player") as? Player!
        player?.initilizePlayer()
        scorelabel = childNode(withName: "ScoreLabel") as? SKLabelNode!;
        scorelabel?.text = "0";
        center = self.frame.size.width / self.frame.size.height
        
        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstnum: 1, secondnum: 2)), target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
        
           Timer.scheduledTimer(timeInterval: TimeInterval(7), target: self, selector: #selector(removeitem), userInfo: nil, repeats: true)
    
     
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x > center {
                moveLeft = false;
            }
            else{
                moveLeft = true
            }
        }
        canMove = true;
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false;
    }
    
    
    // Delegate Methods
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secondBody  = SKPhysicsBody();
        if contact.bodyA.node?.name == "Player"{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            secondBody = contact.bodyA
            firstBody = contact.bodyB
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Fruit"{
            score += 1;
            scorelabel?.text = String(score)
            secondBody.node?.removeFromParent()
            
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Bomb"{
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(restartGame), userInfo: nil, repeats: false)
        }
        
    }
    private func managePlayer(){
        if canMove {
            player?.move(left: moveLeft);
        }
     
        
    }
    @objc func spawnItems(){
        self.scene?.addChild(itemController.spawnItem())
    }

  @objc  func restartGame(){
        
        if let scene = GamePlaySceneClass(fileNamed: "GamePlayScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view!.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(2)));
        }
        
    }
    
@objc   func removeitem(){
        for child in children {
            if child.name == "Fruit" || child.name == "Bomb" {
                if child.position.y < -self.scene!.frame.height - 100 {
                    child.removeFromParent()
                }
            }
        }
        
    }
}
