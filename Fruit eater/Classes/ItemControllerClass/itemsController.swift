//
//  itemsController.swift
//  Fruit eater
//
//  Created by GLB-312-PC on 08/05/18.
//  Copyright © 2018 GLB-312-PC. All rights reserved.
//

import SpriteKit


struct ColliderType {
    static let PLAYER:  UInt32 = 0;
    static let FRUIT_AND_BOMB:  UInt32 = 1
}
class ItemController  {
    private var minX = CGFloat(-200) ,maxX = CGFloat(200)

    
    func spawnItem()-> SKSpriteNode{
        let item : SKSpriteNode?;
        if Int(randomBetweenNumbers(firstnum: 0, secondnum: 10)) >= 6{
            item = SKSpriteNode(imageNamed: "Bomb");
            item!.name = "Bomb";
            item!.setScale(0.6);
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2);
        }
        else{
            let num = Int(randomBetweenNumbers(firstnum: 1, secondnum: 6));
            item = SKSpriteNode(imageNamed: "Fruit\(num)");
            item!.name = "Fruit";
            item!.setScale(0.7);
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2);
        
        }
      
        item!.physicsBody?.categoryBitMask = ColliderType.FRUIT_AND_BOMB

        item!.zPosition = 3;


        item!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        item!.position.x = randomBetweenNumbers(firstnum: minX, secondnum: maxX)
        item!.position.y = 500
        return item!;
    }
    
    
    
    func randomBetweenNumbers(firstnum:CGFloat,secondnum:CGFloat)->CGFloat{
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX)  *
       abs(firstnum - secondnum)  + min(firstnum,secondnum);
        
        
    }
    
    
    
    
    
    
    
    
    
}
