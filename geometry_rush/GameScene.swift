//
//  GameScene.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SceneKit
class GameScene: SCNScene {
    
    fileprivate var player: Player?
    
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
    }
    
    private func createContents(){
                
        player = Player()
        rootNode.addChildNode(player!)
        
        let mainCamera = MainCamera()
        rootNode.addChildNode(mainCamera)
        
        let mainLight = MainLight()
        rootNode.addChildNode(mainLight)
        
        let enemy = Enemy()
        rootNode.addChildNode(enemy)
        
        //test
        let playerLeftUp = Player()
        playerLeftUp.position = SCNVector3(-160, 284, 0)
        rootNode.addChildNode(playerLeftUp)
        
        let playerLeftDown = Player()
        playerLeftDown.position = SCNVector3(-160, -284, 0)
        rootNode.addChildNode(playerLeftDown)
        
        let playerRightUp = Player()
        playerRightUp.position = SCNVector3(160, 284, 0)
        rootNode.addChildNode(playerRightUp)
        
        let playerRightDown = Player()
        playerRightDown.position = SCNVector3(-160, -284, 0)
        rootNode.addChildNode(playerRightDown)
    }
}
