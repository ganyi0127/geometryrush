//
//  MenuScene.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
class MenuScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        scaleMode = .aspectFill
    }
    
    private func createContents(){
        
        let button = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 50))
        button.position = CGPoint(x: sceneSize!.width - 25, y: sceneSize!.height - 25)
        addChild(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach(){
            touch in
            let location = touch.location(in: self)
            let node = nodes(at: location)
            print(node)
        }
    }
}
