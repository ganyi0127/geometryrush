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
    }
}
